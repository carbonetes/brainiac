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

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_lambda_function"
}

has_attribute(key, value) if {
	value in object.keys(key)
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	has_attribute(resource.Attributes, "code_signing_config_arn")
	resource.Attributes.code_signing_config_arn != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "AWS Lambda function is set up to authenticate code-signing.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "AWS Lambda function must be set up to authenticate code-signing.",
		"snippet": block,
	}
}
