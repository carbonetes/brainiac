# METADATA
# title: "Check to make sure that there is no open API access to back-end resources"
# description: "Verify that Data Trace is disabled in API Gateway Method Settings to prevent sensitive data leakage and ensure better security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_settings
# custom:
#   id: CB_TFAWS_251
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_251

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_api_gateway_method_settings"
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

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	resource.Blocks[_].Type == "settings"
	resource.Blocks[_].Attributes.data_trace_enabled == true
}

passed contains result if {
	some block in pass
	result := {
		"message": "CData Trace is disabled in API Gateway Method Settings.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Data Trace must be disabled in API Gateway Method Settings.",
		"snippet": block,
	}
}
