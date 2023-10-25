# METADATA
# title: "Verify VNET Subnet Configuration Includes a Network Security Group (NSG)"
# description: "This policy verifies that Virtual Network (VNET) subnets are appropriately configured with a Network Security Group (NSG)."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
# custom:
#   id: CB_TFAZR_229
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_229

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"azurerm_subnet" in resource.Labels
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

nsgConnect {
	some resource in input
	resource.Type == "resource"
	"azurerm_network_security_group" in resource.Labels
}

nsgaConnect {
	some resource in input
	resource.Type == "resource"
	"azurerm_subnet_network_security_group_association" in resource.Labels
}

fail[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.name == "GatewaySubnet"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.name == "AzureFirewallSubnet"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "delegation"
	some innerblock in block.Blocks
    innerblock.Type == "service_delegation"
    innerblock.Attributes.name == "Microsoft.Netapp/volumes"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not nsgConnect
	not nsgaConnect
}

passed[result] {
	some block in pass
	result := {
		"message": "The VNET subnet configuration includes a Network Security Group (NSG), ensuring network security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The VNET subnet lacks the required Network Security Group (NSG), which poses potential security risks.",
		"snippet": block,
	}
}