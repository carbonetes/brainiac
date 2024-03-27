# METADATA
# title: "Verify that AWS Lambda function is configured for a Dead Letter Queue(DLQ)"
# description: "By configuring a DLQ, any failed or unprocessed events are captured and stored separately, preventing data loss."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
# custom:
#   id: CB_TFAWS_106
#   severity: LOW
package lib.terraform.CB_TFAWS_106

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_lambda_function"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

has_attribute(key, value) if {
	value in object.keys(key)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "dead_letter_config"
	has_attribute(block.Attributes, "target_arn")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_lambda_function' 'dead_letter_config' target_arn is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_lambda_function' 'dead_letter_config' target_arn should be set.",
		"snippet": block,
	}
}