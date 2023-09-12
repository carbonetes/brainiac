# METADATA
# title: "Verify Azure linux scale set does not use basic authentication(Use SSH Key Instead)"
# description: "This policy is designed to enhance the security of Azure Linux Scale Sets by verifying that basic authentication is not in use and SSH key authentication is configured instead."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set
# custom:
#   id: CB_TFAZR_019
#   severity: HIGH
package lib.terraform.CB_TFAZR_019

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "azurerm_linux_virtual_machine_scale_set"
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
	block.Attributes.disable_password_authentication == true
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "Azure Linux Scale Set does not use basic authentication. SSH key authentication is configured.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "Azure Linux Scale Set is using basic authentication instead of SSH key authentication.",
		"snippet": block,
	}
}
