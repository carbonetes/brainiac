# METADATA
# title: "Verify Storage logging is enabled for Table service for read requests"
# description: "This policy is designed to enhance the monitoring and security of Azure Storage by verifying that logging is enabled for read requests in the Table service."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table
# custom:
#   id: CB_TFAZR_237
#   severity: LOW
package lib.terraform.CB_TFAZR_237

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_storage_table" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_storage_account[label] {
	some resource in input
	resource.Type == "resource"
	"azurerm_storage_account" in resource.Labels
	label := concat(".", resource.Labels)
}

is_storage_table_attached {
	some block in input
	block.Type == "resource"
	"azurerm_storage_table" in block.Labels
	some label in label_for_storage_account
	contains(block.Attributes.storage_account_name, label)
}

is_storage_account_attached {
	some block in input
	block.Type == "resource"
	"azurerm_log_analytics_storage_insights" in block.Labels
	some label in label_for_storage_account
	contains(block.Attributes.storage_account_id, label)
	"table_names" in object.keys(block.Attributes)
}

pass[block] {
	some block in input
	isvalid(block)
	is_storage_table_attached
	is_storage_account_attached
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Storage logging is enabled for the Table service for read requests.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Storage logging is not enabled for the Table service for read requests.",
		"snippet": block,
	}
}