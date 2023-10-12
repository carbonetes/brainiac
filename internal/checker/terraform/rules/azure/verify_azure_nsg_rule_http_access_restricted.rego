# METADATA
# title: "Verify that HTTP (port 80) access is restricted from the internet"
# description: "This policy is designed to enhance the security of network resources by verifying that access to HTTP (Port 80) is restricted from the internet."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
# custom:
#   id: CB_TFAZR_175
#   severity: LOW
package lib.terraform.CB_TFAZR_175

import future.keywords.in

supportedResources := ["azurerm_network_security_group", "azurerm_network_security_rule"]

isvalid(block) {
	block.Type == "resource"
	some label in block.Labels
	label in supportedResources
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
	block.Attributes.destination_port_range != "80"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Port 80 access is restricted from the internet.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Port 80 access is not restricted from the internet.",
		"snippet": block,
	}
}