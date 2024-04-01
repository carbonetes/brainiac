# METADATA
# title: "Verify that Lambda function URLs AuthType is not None"
# description: "By requiring an authentication mechanism for Lambda function URLs, such as API key or AWS Identity and Access Management (IAM) authentication, you can prevent unauthorized access to the functions and protect sensitive data and resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest#input_authorization_type
# custom:
#   id: CB_TFAWS_240
#   severity: LOW
package lib.terraform.CB_TFAWS_240
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_lambda_function_url"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if {
    some resource in input
	isvalid(resource)
	resource.Attributes.authorization_type != "NONE"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
    some block in pass
	result := {
		"message": "AWS Lambda function URLs AuthType is not None.",
		"snippet": block,
	}
}

failed contains result if {
    some block in fail
	result := {
		"message": "AWS Lambda function URLs AuthType must be set.",
		"snippet": block,
	}
}
