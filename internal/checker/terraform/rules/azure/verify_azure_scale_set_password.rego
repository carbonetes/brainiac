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

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_linux_virtual_machine_scale_set" in block.Labels
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
	block.Attributes.disable_password_authentication == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Linux Scale Set does not use basic authentication. SSH key authentication is configured.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Linux Scale Set is using basic authentication instead of SSH key authentication.",
		"snippet": block,
	}
}
