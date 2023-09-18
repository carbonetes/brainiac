# METADATA
# title: "Verify that no sensitive credentials are exposed in VM custom_data"
# description: "This policy is designed to enhance the security of virtual machines (VMs) by verifying that no sensitive credentials or confidential information are exposed within the VM custom data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine
# custom:
#   id: CB_TFAZR_013
#   severity: CRITICAL
package lib.terraform.CB_TFAZR_013

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "azurerm_virtual_machine"
}

has_attribute(key, value) {
	_ = key[value]
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
	innerBlock := block.Blocks[_]
	innerBlock.Type == "os_profile"
	not has_attribute(innerBlock.Attributes, "custom_data")
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "No sensitive credentials are exposed in VM custom data.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "Sensitive credentials are exposed in VM custom data.",
		"snippet": block,
	}
}
