# METADATA
# title: "Verify that security rules do not specify 'any' for the 'services' attribute"
# description: "Detect whether security rules within the configuration specify 'any' for the 'services' attribute, as this overly permissive setting can potentially compromise network security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/PaloAltoNetworks/panos/latest/docs/resources/security_policy.html
# custom:
#   id: CB_TFPAN_006
#   severity: LOW
package lib.terraform.CB_TFPAN_006

import future.keywords.in

isvalid(block) {
	supported_resources := ["panos_security_policy", "panos_security_rule_group"]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
}

fail[block] {
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "rule"
	"any" in inner_block.Attributes.services
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The 'services' attribute does not contain 'any'.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The 'services' attribute must not contain 'any'.",
		"snippet": block,
	}
}
