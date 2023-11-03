# METADATA
# title: "Verify Windows VM enables encryption"
# description: "This policy is designed to enhance the security of Windows virtual machines (VMs) by verifying that encryption is enabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine
# custom:
#   id: CB_TFAZR_148
#   severity: LOW
package lib.terraform.CB_TFAZR_148

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_windows_virtual_machine" in block.Labels
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
	block.Attributes.encryption_at_host_enabled == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Encryption is enabled for the Windows virtual machine.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Encryption is not enabled for the Windows virtual machine.",
		"snippet": block,
	}
}