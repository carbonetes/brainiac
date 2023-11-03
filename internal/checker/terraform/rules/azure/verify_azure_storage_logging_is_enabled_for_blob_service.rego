# METADATA
# title: "Verify Storage logging is enabled for Blob service for read requests"
# description: "This policy is designed to enhance the monitoring and security of Azure Storage by verifying that logging is enabled for read requests in the Blob service."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container
# custom:
#   id: CB_TFAZR_238
#   severity: LOW
package lib.terraform.CB_TFAZR_238

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_storage_container" in block.Labels
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

is_storage_container_attached {
	some block in input
	block.Type == "resource"
	"azurerm_storage_container" in block.Labels
	some label in label_for_storage_account
	contains(block.Attributes.storage_account_name, label)
}

is_storage_account_attached {
	some block in input
	block.Type == "resource"
	"azurerm_log_analytics_storage_insights" in block.Labels
	some label in label_for_storage_account
	contains(block.Attributes.storage_account_id, label)
	"blob_container_names" in object.keys(block.Attributes)
}

pass[block] {
	some block in input
	isvalid(block)
	is_storage_container_attached
	is_storage_account_attached
	valid_values := ["private", "blob"]
	value := block.Attributes.container_access_type
	value in valid_values
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Storage logging is enabled for Blob service for read requests.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Storage logging is not enabled for Blob service for read requests.",
		"snippet": block,
	}
}