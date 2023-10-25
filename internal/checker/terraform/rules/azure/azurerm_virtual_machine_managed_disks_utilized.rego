# METADATA
# title: "Guarantee that Virtual Machines are making use of Managed Disks while maintaining security and compliance"
# description: "Verify that Virtual Machines are configured to employ Managed Disks, enhancing security and compliance."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_machine
# custom:
#   id: CB_TFAZR_220
#   severity: LOW
package lib.terraform.CB_TFAZR_220

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_virtual_machine" in block.Labels
}

has_attribute(key, value) {
	_ = key[value]
}

pass[block] {
	some block in input
	isvalid(block)
	some innerBlock in block.Blocks
	innerBlock.Type == "storage_os_disk"
	has_attribute(innerBlock.Attributes, "managed_disk_type")
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Managed Disks are used by Virtual Machines.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Managed Disks must be used by Virtual Machines.",
		"snippet": block,
	}
}
