# METADATA
# title: "Verify SageMaker Users should not have root access to SageMaker notebook instances"
# description: "By controlling access and adhering to security best practices, this measure promotes a more secure and controlled environment for machine learning workflows in Amazon SageMaker."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rgeraskin/aws2/latest/docs/resources/sagemaker_notebook_instance
# custom:
#   id: CB_TFAWS_290
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_290

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
    resource.Attributes.root_access == "Disabled"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_sagemaker_notebook_instance' root_access is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_sagemaker_notebook_instance' root_access should be Disabled",
                "snippet": block }
}
