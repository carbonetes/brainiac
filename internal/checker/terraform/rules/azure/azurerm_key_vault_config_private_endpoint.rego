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

isvalid(block) {
	block.Type == "resource"
	"azurerm_key_vault" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_private_endpoint[label] {
	some block in input
	block.Type == "resource"
	"azurerm_private_endpoint" in block.Labels
	label := concat(".", block.Labels)
}

endpoint_is_attached {
	some block in input
	block.Type == "resource"
	some label in label_for_private_endpoint
	contains(block.Attributes.resource_group_name, label)
}

pass[block] {
	some block in input
	isvalid(block)
	endpoint_is_attached
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
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