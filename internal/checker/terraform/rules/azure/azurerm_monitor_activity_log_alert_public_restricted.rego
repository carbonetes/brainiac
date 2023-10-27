# METADATA
# title: "Verify that the storage container housing the activity logs is not reachable by the public"
# description: "Confirm that the storage container housing activity logs does not have public access to maintain security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container.html
# custom:
#   id: CB_TFAZR_230
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_230

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

label_for_storage_acc[label] {
	some block in input
	block.Type == "resource"
	"azurerm_storage_account" in block.Labels
	label := concat(".", block.Labels)
}

storage_is_attached_in_container {
	some block in input
	block.Type == "resource"
	"azurerm_storage_container" in block.Labels
	some label in label_for_storage_acc
	contains(block.Attributes.storage_account_id, label)
}

storage_is_attached_in_activity_log {
	some block in input
	block.Type == "resource"
	"azurerm_monitor_activity_log_alert" in block.Labels
	some label in label_for_storage_acc
	some inner_block in block.Blocks
	inner_block.Type == "criteria"
	contains(block.Attributes.resource_id, label)
}

pass[block] {
	some block in input
	isvalid(block)
	storage_is_attached_in_container
	storage_is_attached_in_activity_log
	block.Attributes.container_access_type == "private"
}

pass[block] {
	some block in input
	isvalid(block)
	storage_is_attached_in_container
	storage_is_attached_in_activity_log
}

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.container_access_type == "private"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Storage container is set to private.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Storage container must be set to private.",
		"snippet": block,
	}
}
