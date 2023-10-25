# METADATA
# title: "Verify Storage Account Configuration with Private Endpoint"
# description: "This policy checks whether Azure Storage Accounts are properly configured with a private endpoint for enhanced security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
# custom:
#   id: CB_TFAZR_233
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_233

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"azurerm_storage_account" in resource.Labels
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
		"message": "The Azure Storage Account is configured with a private endpoint, enhancing security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Azure Storage Account does not have a private endpoint, which can be a security risk.",
		"snippet": block,
	}
}