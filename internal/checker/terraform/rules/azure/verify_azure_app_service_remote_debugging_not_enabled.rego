# METADATA
# title: "Verify that remote debugging is not enabled for app services"
# description: "This policy is designed to enhance the security and management of Azure App Services by verifying that remote debugging is disabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# custom:
#   id: CB_TFAZR_035
#   severity: LOW
package lib.terraform.CB_TFAZR_035

import future.keywords.in

isvalid(block) {
	supported_resources := ["azurerm_app_service", "azurerm_linux_web_app", "azurerm_windows_web_app"]
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

pass[block] {
    some block in input
	isvalid(block)
    some inner_blocks in block.Blocks
	inner_blocks.Type == "site_config"
	inner_blocks.Attributes.remote_debugging_enabled == false
}

fail[block] {
    some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
    some block in pass
	result := {
		"message": "Remote debugging is not enabled for the App Service.",
		"snippet": block,
	}
}

failed[result] {
    some block in fail
	result := {
		"message": "Remote debugging is enabled for the App Service.",
		"snippet": block,
	}
}