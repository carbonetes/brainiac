# METADATA
# title: "Secure important data storage using a Customer Managed Key"
# description: "Make certain that sensitive data storage is protected through the use of a Customer Managed Key."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_customer_managed_key
# custom:
#   id: CB_TFAZR_202
#   severity: HIGH
package lib.terraform.CB_TFAZR_202

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_storage_account_customer_managed_key" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_storage_acc[label] {
	some block in input
	block.Type == "resource"
	"azurerm_storage_account" in block.Labels
	label := concat(".", block.Labels)
}

storage_is_attached {
	some block in input
	block.Type == "resource"
	"azurerm_storage_account_customer_managed_key" in block.Labels
	some label in label_for_storage_acc
	contains(block.Attributes.storage_account_id, label)
}

pass[block] {
	some block in input
	isvalid(block)
	storage_is_attached
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
