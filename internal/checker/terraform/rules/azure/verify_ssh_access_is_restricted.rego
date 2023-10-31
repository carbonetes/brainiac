# METADATA
# title: "Verify that SSH access is restricted from the internet"
# description: "By limiting SSH access to trusted networks or specific IP addresses, you reduce the exposure of your systems to potential security threats and unauthorized access attempts."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
# custom:
#   id: CB_TFAZR_063
#   severity: HIGH
package lib.terraform.CB_TFAZR_063

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
	"22" in resource.Attributes.destination_port_range
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
		"message": "SSH access is restricted from the internet.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "SSH access should be restricted from the internet.",
		"snippet": block,
	}
}
