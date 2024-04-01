# METADATA
# title: "Confirm proper validation of AWS API gateway requests"
# description: "Verify the implementation of thorough validation for incoming requests within AWS API gateways. This security measure fortifies the prevention of unauthorized or malicious requests."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method.html
# custom:
#   id: CB_TFAWS_356
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_356

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_api_gateway_method"
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
	has_attribute(resource.Attributes, "request_validator_id")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "The AWS API gateway requests has proper validation.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "The AWS API gateway requests must have proper validation.",
		"snippet": block,
	}
}
