# METADATA
# title: "Verify that AWS Lambda function is configured for function-level concurrent execution limit"
# description: "This allows for better resource allocation, prevents performance degradation, and enhances the overall stability and scalability of the Lambda function."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
# custom:
#   id: CB_TFAWS_104
#   severity: LOW
package lib.terraform.CB_TFAWS_104

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
	has_attribute(resource.Attributes, "reserved_concurrent_executions")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_lambda_function' 'reserved_concurrent_executions' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_lambda_function' 'reserved_concurrent_executions' should be set properly.",
		"snippet": block,
	}
}