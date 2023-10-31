# METADATA
# title: "Verify that Virtual machine scale sets have encryption at host enabled"
# description: "Verifying that Virtual Machine Scale Sets have encryption at host enabled enhances data security and compliance."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set
# custom:
#   id: CB_TFAZR_079
#   severity: LOW
package lib.terraform.CB_TFAZR_079

import future.keywords.in

supported_resources := ["azurerm_linux_virtual_machine_scale_set", "azurerm_windows_virtual_machine_scale_set"]
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

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.encryption_at_host_enabled == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Virtual machine scale sets encryption_at_host_enabled is set properly.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Virtual machine scale sets encryption_at_host_enabled should be set to true.",
		"snippet": block,
	}
}
