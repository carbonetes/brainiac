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

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_virtual_machine" in block.Labels
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
	some inner_block in block.Blocks
	inner_block.Type == "os_profile"
	not "custom_data" in object.keys(inner_block.Attributes)
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "No sensitive credentials are exposed in VM custom data.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Sensitive credentials are exposed in VM custom data.",
		"snippet": block,
	}
}
