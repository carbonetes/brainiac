# METADATA
# title: "Enable Automatic Updates for Windows VMs"
# description: "Make sure that Windows VMs are configured to automatically apply updates to enhance security and keep the operating system up-to-date"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine
# custom:
#   id: CB_TFAZR_147
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_147

import future.keywords.in

supportedResources := [
	"azurerm_windows_virtual_machine",
	"azurerm_windows_virtual_machine_scale_set",
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
	resource.Attributes.enable_automatic_updates == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Automatic updates are enabled for Windows VMs.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Automatic updates must be enabled for Windows VMs.",
		"snippet": block,
	}
}
