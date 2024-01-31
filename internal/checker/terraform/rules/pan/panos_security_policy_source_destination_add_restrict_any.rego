# METADATA
# title: "Verify that security rules do not have both 'source_addresses' and 'destination_addresses' set to 'any'"
# description: "Confirm that security rules do not specify 'source_addresses' and 'destination_addresses' as 'any' simultaneously to avoid overly permissive configurations."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/PaloAltoNetworks/panos/latest/docs/resources/security_policy.html
# custom:
#   id: CB_TFPAN_007
#   severity: MEDIUM
package lib.terraform.CB_TFPAN_007

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
	"any" in inner_block.Attributes.destination_addresses
	"any" in inner_block.Attributes.source_addresses
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The 'source_addresses' and 'destination_addresses' attributes are not set to 'any'.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The 'source_addresses' and 'destination_addresses' attributes must not be set to 'any'.",
		"snippet": block,
	}
}
