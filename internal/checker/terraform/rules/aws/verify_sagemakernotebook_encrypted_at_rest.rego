# METADATA
# title: "Verify SageMaker Notebook is encrypted at rest using KMS CMK"
# description: "This ensures that any sensitive data that may be stored on the notebook instance is protected from unauthorized access in case of data leakage or theft."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_notebook_instance
# custom:
#   id: CB_TFAWS_039
#   severity: HIGH
package lib.terraform.CB_TFAWS_039

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_sagemaker_notebook_instance"
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "kms_key_id")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_sagemaker_notebook_instance' 'kms_key_id' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_sagemaker_notebook_instance' 'kms_key_id' should be set.",
                "snippet": block }
} 