# METADATA
# title: "Verify Private Endpoint Configuration for Key Vault"
# description: "This policy ensures that a private endpoint is correctly configured to connect to an Azure Key Vault."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
# custom:
#   id: CB_TFAZR_232
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_232

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"azurerm_key_vault" in resource.Labels
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
    azurermPrivateEndpointConnect
}

azurermPrivateEndpointConnect {
	some resource in input
	resource.Type == "resource"
	"azurerm_private_endpoint" in resource.Labels
}


fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The private endpoint is successfully configured to connect to the Key Vault, enhancing security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The private endpoint is not configured to connect to the Key Vault, which could result in a potential security vulnerability.",
		"snippet": block,
	}
}