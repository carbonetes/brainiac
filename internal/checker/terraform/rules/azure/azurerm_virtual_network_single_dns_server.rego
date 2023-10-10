# METADATA
# title: "Mandatory presence of a minimum of 2 connected DNS Endpoints in VNET"
# description: "This policy mandates that a Virtual Network (VNET) must have a minimum of two connected DNS Endpoints configured for enhanced network reliability and redundancy"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
# custom:
#   id: CB_TFAZR_158
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_158

import future.keywords.in

supportedResources := [
	"azurerm_virtual_network",
	"azurerm_virtual_network_dns_servers",
]

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

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

fail[resource] {
	some resource in input
	isvalid(resource)
	has_attribute(resource.Attributes, "dns_servers")
	count(resource.Attributes.dns_servers) == 1
}

has_attribute(key, value) {
  _ = key[value]
}

passed[result] {
	some block in pass
	result := {"message": "The VNET complies with the policy by having at least 2 connected DNS Endpoints, ensuring network reliability and redundancy."}
}

failed[result] {
	some block in fail
	result := {"message": "The VNET does not meet the policy requirement of having at least 2 connected DNS Endpoints, potentially affecting network reliability."}
}
