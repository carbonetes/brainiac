# METADATA
# title: "Verify that direct internet access is disabled for an Amazon SageMaker Notebook Instance"
# description: "By disabling direct internet access, the notebook instance is isolated from the public internet, reducing the risk of unauthorized access or data exfiltration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_notebook_instance#direct_internet_access
# custom:
#   id: CB_TFAWS_117
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_117

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_sagemaker_notebook_instance"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.direct_internet_access == "Disabled"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_sagemaker_notebook_instance' direct_internet_access is disabled.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_sagemaker_notebook_instance' direct_internet_access should be disabled.",
                "snippet": block }
}
