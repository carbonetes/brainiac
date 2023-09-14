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

supportedResources := ["azurerm_linux_virtual_machine", "azurerm_windows_virtual_machine"]

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == supportedResources[_]
}

resource[resource] {
	block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
	block := fail[_]
	resource := concat(".", block.Labels)
}

pass[block] {
	block := input[_]
	isvalid(block)
	block.Attributes.allow_extension_operations == false
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "No virtual machine extensions are installed on the virtual machine.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "Virtual machine extensions are installed on the virtual machine.",
		"snippet": block,
	}
}
