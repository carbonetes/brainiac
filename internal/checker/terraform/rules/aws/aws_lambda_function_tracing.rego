# METADATA
# title: "Ensure that tracing is enabled for AWS Lambda functions"
# description: "When using lambda functions, you can use X-Ray tracing to visualize and diagnose errors, identify performance problems, and look into requests that gave rise to errors."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
# custom:
#   id: CB_TFAWS_026
#   severity: LOW
package lib.terraform.CB_TFAWS_026

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
	expectedvalues := ["Active", "PassThrough"]
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "tracing_config"
	has_attribute(block.Attributes, "mode")
	block.Attributes.mode in expectedvalues
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "aws_lambda_function tracing is active.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "aws_lambda_function tracing should be active.",
		"snippet": block,
	}
}
