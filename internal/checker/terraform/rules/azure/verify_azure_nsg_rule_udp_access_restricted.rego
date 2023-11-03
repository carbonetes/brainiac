# METADATA
# title: "Verify that UDP Services are restricted from the Internet"
# description: "This policy is designed to enhance network security by verifying that UDP (User Datagram Protocol) services are appropriately restricted from internet access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
# custom:
#   id: CB_TFAZR_044
#   severity: HIGH
package lib.terraform.CB_TFAZR_044

import future.keywords.in

isvalid(block) {
	supported_resources := ["azurerm_network_security_group", "azurerm_network_security_rule"]
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

pass[block] {
	some block in input
	isvalid(block)
	some innerBlock in block.Blocks
	innerBlock.Type == "security_rule"
}

fail[block] {
	some block in input
	isvalid(block)
	some innerBlock in block.Blocks
	innerBlock.Attributes.protocol == "Udp"
	innerBlock.Type == "security_rule"
	innerBlock.Attributes.direction == "Inbound"
	innerBlock.Attributes.access == "Allow"
	internetAddresses := ["*", "0.0.0.0", "<nw>/0", "/0", "internet", "any"]
	innerBlock.Attributes.source_address_prefix in internetAddresses
}

passed[result] {
	some block in pass
	result := {
		"message": "UDP Services are restricted from the Internet.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "UDP Services are not restricted from the Internet.",
		"snippet": block,
	}
}