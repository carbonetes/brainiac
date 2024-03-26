# METADATA
# title: "Verify API Gateway method setting caching is set to encrypted"
# description: "Verifying that API Gateway method setting caching is set to encrypted enhances data security by ensuring that cached data remains confidential and protected from unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/2.49.0/docs/resources/api_gateway_method_settings#cache_data_encrypted
# custom:
#   id: CB_TFAWS_291
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_291

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_api_gateway_method_settings"
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
	resource.Blocks[_].Type == "settings"
	resource.Blocks[_].Attributes.cache_data_encrypted == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "API Gateway method setting caching is set to encrypted.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "API Gateway method setting caching must be encrypted",
		"snippet": block,
	}
}
