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

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "aws_lambda_function_url"
}

resource[resource] {
	block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
	block := fail[_]
	resource := concat(".", block.Labels)
}

pass[resource] {
	resource := input[_]
	isvalid(resource)
	resource.Attributes.authorization_type != "NONE"
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "AWS Lambda function URLs AuthType is not None.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "AWS Lambda function URLs AuthType must be set.",
		"snippet": block,
	}
}
