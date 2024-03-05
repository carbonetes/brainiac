# METADATA
# title: "Verify that security policies have descriptions filled in"
# description: "Confirm that descriptions are provided for security policies."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/PaloAltoNetworks/panos/latest/docs/resources/security_policy.html
# custom:
#   id: CB_TFPAN_008
#   severity: LOW
package lib.terraform.CB_TFPAN_008

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
	block.Attributes.description == ""
}

fail[block] {
	some block in input
	isvalid(block)
	not "description" in object.keys(block.Attributes)
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The attribute 'description' is present and is not an empty string.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The attribute 'description' is either not present or is an empty string.",
		"snippet": block,
	}
}
