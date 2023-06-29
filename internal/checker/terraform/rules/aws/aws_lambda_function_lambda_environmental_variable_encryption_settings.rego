# METADATA
# title: "For the Lambda environmental variable, verify the encryption settings"
# description: "By enforcing appropriate encryption settings, organizations can enhance the overall security of their Lambda functions and protect sensitive information from unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.1.0/docs/resources/lambda_function
# custom:
#   id: CB_TFAWS_165
#   severity: LOW
package lib.terraform.CB_TFAWS_165

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_lambda_function"
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
    has_attribute(resource.Attributes, "kms_key_arn")
    resource.Attributes.kms_key_arn != ""
    contains(resource.Blocks[_].Type, "environment")
}


fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Encryption settings are enforced for the lambda environmental variable.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Encryption settings must be enforced for the lambda environmental variable.",
                "snippet": block }
} 