# METADATA
# title: "Verify that IP forwarding is disabled for Network Interfaces"
# description: "Confirm that Network Interfaces have IP forwarding disabled, enhancing network security by preventing the forwarding of IP packets within the network"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
# custom:
#   id: CB_TFAZR_121
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_121

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_network_interface" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.enable_ip_forwarding == false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "IP forwarding is verified to be disabled for Network Interfaces.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "IP forwarding is not disabled for Network Interfaces as required.",
		"snippet": block,
	}
}
