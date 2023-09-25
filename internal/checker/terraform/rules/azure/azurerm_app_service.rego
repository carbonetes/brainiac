# METADATA
# title: "Make sure App Service Authentication is activated on your Azure App Service"
# description: "Enable App Service Authentication on your Azure App Service to enhance security and add user authentication and authorization to your web application."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# custom:
#   id: CB_TFAZR_045
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_045

import future.keywords.in

supportedResources := [
	"azurerm_linux_web_app",
	"azurerm_windows_web_app",
	"azurerm_app_service",
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
	innerBlock.Type == "auth_settings"
	innerBlock.Attributes.enabled == true
}

pass[resource] {
	some resource in input
	isvalid(resource)
	some innerBlock in resource.Blocks
	innerBlock.Type == "auth_settings_v2"
	innerBlock.Attributes.auth_enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure App Service is set to be always on.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure App Service is not set to be always on.",
		"snippet": block,
	}
}
