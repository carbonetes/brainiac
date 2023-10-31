# METADATA
# title: "Verify debugging is disabled for the App service slot"
# description: "This policy is designed to enhance the security and stability of Azure App Service Slots by verifying that debugging is disabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_slot
# custom:
#   id: CB_TFAZR_169
#   severity: LOW
package lib.terraform.CB_TFAZR_169

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_app_service_slot" in block.Labels
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
	some innerBlock in block.Blocks
	innerBlock.Type == "site_config"
	innerBlock.Attributes.remote_debugging_enabled == false
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Remote debugging is disabled for the Azure App Service Slot.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Remote debugging is not disabled for the Azure App Service Slot.",
		"snippet": block,
	}
}