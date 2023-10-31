# METADATA
# title: "Verify Virtual Machine Extensions are not Installed"
# description: "This policy aims to enhance the security and management of virtual machines (VMs) by verifying that no additional or unnecessary virtual machine extensions are installed."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
# custom:
#   id: CB_TFAZR_022
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_022

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	some label in block.Labels
	supported_resources := ["azurerm_linux_virtual_machine", "azurerm_windows_virtual_machine"]
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

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.allow_extension_operations == false
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "No virtual machine extensions are installed on the virtual machine.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Virtual machine extensions are installed on the virtual machine.",
		"snippet": block,
	}
}
