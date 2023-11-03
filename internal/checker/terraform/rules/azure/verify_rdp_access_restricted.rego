# METADATA
# title: "Verify that RDP access is restricted from the internet"
# description: "RDP is a protocol used for remote access to Windows-based computers, and allowing unrestricted access to it from the internet can pose significant security risks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
# custom:
#   id: CB_TFAZR_061
#   severity: HIGH
package lib.terraform.CB_TFAZR_061

import future.keywords.in

supported_resources := ["azurerm_network_security_group", "azurerm_network_security_rule"]

isvalid(block) {
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

fail[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.access == "Allow"
	"3389" in resource.Attributes.destination_port_range
	resource.Attributes.protocol == "TCP"
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "RDP access is restricted from the internet.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "RDP access should be restricted from the internet.",
		"snippet": block,
	}
}
