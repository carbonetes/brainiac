# METADATA
# title: "Verify that security rules do not utilize 'any' for the 'applications' attribute"
# description: "Confirm that security rules within the configuration do not utilize the 'any' value for the 'applications' attribute."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/PaloAltoNetworks/panos/latest/docs/resources/security_policy.html
# custom:
#   id: CB_TFPAN_005
#   severity: HIGH
package lib.terraform.CB_TFPAN_005

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
	"any" in inner_block.Attributes.applications
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The value 'any' is not found in the 'applications' attribute",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The value 'any' must not be utilized for the  'applications' attribute.",
		"snippet": block,
	}
}
