# METADATA
# title: "Verify that Interface Management Profiles do not have plain-text management Telnet activated"
# description: "Confirm that that plain-text management Telnet is deactivated for an Interface Management Profile. Allowing Telnet in a management profile poses a security risk as credentials and data can be transmitted in plaintext, making it vulnerable to interception by malicious actors."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/PaloAltoNetworks/panos/latest/docs/resources/management_profile
# custom:
#   id: CB_TFPAN_003
#   severity: HIGH
package lib.terraform.CB_TFPAN_003

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"panos_management_profile" in block.Labels
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
	inner_block.Type == "telnet"
	inner_block.Attributes.enable == true
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Attribute 'enable' is set to 'false'.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Attribute 'enable' must not be set to 'true'.",
		"snippet": block,
	}
}
