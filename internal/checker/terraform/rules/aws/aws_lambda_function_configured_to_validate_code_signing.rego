# METADATA
# title: "Verify that the AWS Lambda function is set up to authenticate code-signing"
# description: "Verify that an AWS Lambda function is appropriately configured to authenticate and validate code-signing, enhancing the security of the function's code execution."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
# custom:
#   id: CB_TFAWS_248
#   severity: HIGH
package lib.terraform.CB_TFAWS_248

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
    has_attribute(resource.Attributes, "code_signing_config_arn")
    resource.Attributes.code_signing_config_arn != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "AWS Lambda function is set up to authenticate code-signing.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "AWS Lambda function must be set up to authenticate code-signing.",
                "snippet": block }
} 