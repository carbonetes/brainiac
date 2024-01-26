# METADATA
# title: "Verify that the Disable Server Response Inspection (DSRI) is not activated in security policies"
# description: "Confirm that security policies do not activate Disable Server Response Inspection (DSRI). Confirming this condition assures that server-to-client inspection integrity remains intact."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/PaloAltoNetworks/panos/latest/docs/resources/security_policy.html
# custom:
#   id: CB_TFPAN_004
#   severity: MEDIUM
package lib.terraform.CB_TFPAN_004

import future.keywords.in

isvalid(block) {
	supported_resources := ["panos_security_policy", "panos_security_rule_group"]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[block] {
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "rule"
	inner_block.Attributes.disable_server_response_inspection == true
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "API keys and password are not hardcoded.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "API key and password must not be hardcoded.",
		"snippet": block,
	}
}
