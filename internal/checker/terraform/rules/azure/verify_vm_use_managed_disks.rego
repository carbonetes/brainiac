# METADATA
# title: "Verify that Virtual Machines use managed disks"
# description: "Managed disks simplify disk management, enhance data protection, and improve scalability for VMs."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
# custom:
#   id: CB_TFAZR_066
#   severity: LOW
package lib.terraform.CB_TFAZR_066

import future.keywords.in

supported_resources := ["azurerm_linux_virtual_machine", "azurerm_windows_virtual_machine"]
isvalid(block) {
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some inner_block in resource.Blocks
	inner_block.Type == "storage_os_disk"
	inner_block.Attributes.vhd_uri != ""
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some inner_block in resource.Blocks
	inner_block.Type == "storage_data_disk"
	inner_block.Attributes.vhd_uri != ""
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Virtual Machines use managed disks.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Virtual Machines should use managed disks.",
		"snippet": block,
	}
}
