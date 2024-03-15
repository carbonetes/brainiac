# METADATA
# title: "Require Linux VMs to use SSH keys for secure communication"
# description: "Make sure that Linux VMs are configured to use SSH keys for secure communication, which is essential for enhancing security by eliminating the need for password-based authentication"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set
# custom:
#   id: CB_TFAZR_152
#   severity: HIGH
package lib.terraform.CB_TFAZR_152

import future.keywords.in

supportedResources := [
	"azurerm_linux_virtual_machine",
	"azurerm_linux_virtual_machine_scale_set"
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
	some innerBlock in resource.Blocks
	innerBlock.Type == "admin_ssh_key"
	innerBlock.Attributes.public_key != null
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "SSH key-based authentication is enabled for secure communication on Linux VMs.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "SSH key-based authentication must be enabled for secure communication on Linux VMs.",
		"snippet": block,
	}
}