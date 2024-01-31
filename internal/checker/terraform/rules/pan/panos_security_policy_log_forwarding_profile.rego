# METADATA
# title: "Verify that a Log Forwarding Profile is designated for every security policy rule"
# description: "Confirm that each security policy rule has a Log Forwarding Profile assigned to it. This ensures that logs are appropriately forwarded for monitoring and analysis purposes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/PaloAltoNetworks/panos/latest/docs/resources/security_policy.html
# custom:
#   id: CB_TFPAN_009
#   severity: MEDIUM
package lib.terraform.CB_TFPAN_009

import future.keywords.in

isvalid(block) {
	supported_resources := ["panos_security_policy", "panos_security_rule_group"]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
}

pass[block] {
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "rule"
	inner_block.Attributes.log_setting != ""
}

pass[block] {
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "rule"
	"log_setting" in object.keys(inner_block.block.Attributes)
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The attribute 'log_setting' is present and is not an empty string.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The attribute 'log_setting' is either not present or is an empty string.",
		"snippet": block,
	}
}
