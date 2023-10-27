# METADATA
# title: "Verify that Unattached disks are encrypted"
# description: "This policy is designed to enhance data security and compliance by verifying that unattached disks are encrypted."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine
# custom:
#   id: CB_TFAZR_242
#   severity: LOW
package lib.terraform.CB_TFAZR_242

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

label_for_managed_disk[label] {
	some resource in input
	resource.Type == "resource"
	"azurerm_managed_disk" in resource.Labels
	label := concat(".", resource.Labels)
}

is_managed_disk_attached {
	some block in input
	block.Type == "resource"
	"azurerm_virtual_machine" in block.Labels
	some label in label_for_managed_disk
	some innerBlock in block.Blocks
	contains(innerBlock.Attributes.managed_disk_id, label)
}

is_managed_disk_encrypted {
	some block in input
	block.Type == "resource"
	"azurerm_managed_disk" in block.Labels
	some innerBlock in block.Blocks
	innerBlock.Type == "encryption_settings"
	innerBlock.Attributes.enabled != false
}

pass[block] {
	some block in input
	isvalid(block)
	is_managed_disk_attached
	is_managed_disk_encrypted
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Unattached disks are encrypted.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Unattached disks are not encrypted.",
		"snippet": block,
	}
}