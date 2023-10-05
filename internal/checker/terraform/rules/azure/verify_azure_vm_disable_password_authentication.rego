# METADATA
# title: "Verify that Virtual machine does not enable password authentication"
# description: "This policy is designed to enhance the security of virtual machines (VMs) by verifying that password authentication is disabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
# custom:
#   id: CB_TFAZR_134
#   severity: LOW
package lib.terraform.CB_TFAZR_134

import future.keywords.in

supportedResources := ["azurerm_linux_virtual_machine", "azurerm_linux_virtual_machine_scale_set"]

isvalid(block) {
	block.Type == "resource"
	some label in block.Labels
	label in supportedResources
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
	block.Attributes.disable_password_authentication != false
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Password authentication is disabled for the virtual machine.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Password authentication is enabled for the virtual machine.",
		"snippet": block,
	}
}