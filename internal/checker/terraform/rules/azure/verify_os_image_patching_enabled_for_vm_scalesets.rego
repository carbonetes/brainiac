# METADATA
# title: "Verify that automatic OS image patching is enabled for Virtual Machine Scale Sets"
# description: "Verifying automatic OS image patching for Virtual Machine Scale Sets enhances security, reliability, and efficiency by automating critical updates, reducing downtime, ensuring compliance, and saving time and costs."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set
# custom:
#   id: CB_TFAZR_075
#   severity: LOW
package lib.terraform.CB_TFAZR_075

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_virtual_machine_scale_set" in block.Labels
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
	some inner_block in resource.Blocks
	inner_block.Type == "os_profile_windows_config"
	inner_block.Attributes.enable_automatic_upgrades == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "'azurerm_virtual_machine_scale_sets' enable_automatic_upgrades is set properly.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "'azurerm_virtual_machine_scale_sets' enable_automatic_upgrades shoul be set to true under 'os_profile_windows_config'.",
		"snippet": block,
	}
}
