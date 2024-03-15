# METADATA
# title: "Verify VM Agent Installation"
# description: "Ensure that the VM Agent is correctly installed on virtual machines for enhanced management and monitoring"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
# custom:
#   id: CB_TFAZR_153
#   severity: LOW
package lib.terraform.CB_TFAZR_153

import future.keywords.in

supportedResources := [
	"azurerm_windows_virtual_machine",
	"azurerm_windows_virtual_machine_scale_set",
	"azurerm_linux_virtual_machine_scale_set",
	"azurerm_linux_virtual_machine",
]

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

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.provision_vm_agent == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "VM Agent is installed and configured correctly.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "VM Agent is not installed. Please ensure that the VM Agent is installed on your virtual machines for effective management and monitoring.",
		"snippet": block,
	}
}
