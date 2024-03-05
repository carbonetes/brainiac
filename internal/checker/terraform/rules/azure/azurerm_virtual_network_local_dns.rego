# METADATA
# title: "Require VNET to Utilize On-Premises DNS Addresses"
# description: "This policy mandates that a Virtual Network (VNET) configuration should utilize DNS addresses that are located on-premises or within the local network. Using local DNS addresses can enhance network reliability and reduce dependence on external DNS servers"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
# custom:
#   id: CB_TFAZR_160
#   severity: HIGH
package lib.terraform.CB_TFAZR_160

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_virtual_network" in block.Labels
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
	resource.Attributes.address_space != null
	resource.Attributes.dns_servers != null
	not dns_server_within_address_space(resource.Attributes.dns_servers, resource.Attributes.address_space)
}

dns_server_within_address_space(dns_servers, address_space) {
	some dns_server in dns_servers
	not net.cidr_contains(address_space[0], dns_server)
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The VNET configuration utilizes local DNS addresses, enhancing network reliability.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The VNET configuration does not utilize local DNS addresses, potentially relying on external DNS servers.",
		"snippet": block,
	}
}
