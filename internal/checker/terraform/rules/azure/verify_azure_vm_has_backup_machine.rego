# METADATA
# title: "Verify that virtual machines are backed up using Azure Backup"
# description: "This policy is designed to enhance data protection and disaster recovery for virtual machines by verifying that Azure Backup is configured and actively used."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine
# custom:
#   id: CB_TFAZR_208
#   severity: LOW
package lib.terraform.CB_TFAZR_208

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_virtual_machine" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

getTheLabelforAzureVM[label] {
	some block in input
	block.Type == "resource"
	"azurerm_virtual_machine" in block.Labels
	label := concat(".", block.Labels)
}

isValidResourceAttached {
	some block in input
	block.Type == "resource"
	"azurerm_backup_protected_vm" in block.Labels
	some label in getTheLabelforAzureVM
	contains(block.Attributes.source_vm_id, label)
}

pass[block] {
	some block in input
	isvalid(block)
	isValidResourceAttached
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Virtual Machines are backed up using Azure Backup.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Virtual Machines are not backed up using Azure Backup.",
		"snippet": block,
	}
}