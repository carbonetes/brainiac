# METADATA
# title: "Verify Storage Account Configuration with Private Endpoint"
# description: "This policy checks whether Azure Storage Accounts are properly configured with a private endpoint for enhanced security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_customer_managed_key
# custom:
#   id: CB_TFAZR_233
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_233

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_storage_account" in block.Labels
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
		"message": "Important data storage is secured using a Customer Managed Key.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Important data storage must be secured using a Customer Managed Key.",
		"snippet": block,
	}
}