# METADATA
# title: "Confirm that logging at the end of sessions is activated in security policies"
# description: "Verify that logging at the end of sessions is activated in security policies to assure comprehensive monitoring and auditing of network activities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/PaloAltoNetworks/panos/latest/docs/resources/security_policy.html
# custom:
#   id: CB_TFPAN_010
#   severity: LOW
package lib.terraform.CB_TFPAN_010

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
	inner_block.Attributes.log_end == false
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The attribute 'log_end' not set to 'false'.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The attribute 'log_end' must not be set to 'false'.",
		"snippet": block,
	}
}
