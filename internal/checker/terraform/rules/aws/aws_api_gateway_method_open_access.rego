# METADATA
# title: "Check to make sure that there is no open API access to back-end resources"
# description: "By default, AWS API gateway methods are available to the public. Unprotected APIs can result in security lapses and data spills."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method
# custom:
#   id: CB_TFAWS_057
#   severity: LOW
package lib.terraform.CB_TFAWS_057

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_api_gateway_method"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	api_key_required := resource.Attributes.api_key_required
	authorization := resource.Attributes.authorization
	http_method := resource.Attributes.http_method
	authorization == "NONE"
	http_method != "OPTIONS"
	api_key_required == false
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "aws_api_gateway_method has no open access to back-end resources through API.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "aws_api_gateway_method should have no open access to back-end resources through API.",
		"snippet": block,
	}
}

