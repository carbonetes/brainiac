# METADATA
# title: "Verify Health Check Configuration for App Service"
# description: "This policy verifies that the App Service is configured with a health check to monitor the application's status and performance."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# custom:
#   id: CB_TFAZR_211
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_211

import future.keywords.in

supportedResources := [
	"azurerm_app_service", 
    "azurerm_linux_web_app", 
    "azurerm_windows_web_app"
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
	some block in resource.Blocks
	block.Type == "site_config"
	block.Attributes.health_check_path != ""
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The App Service has a health check configured, which helps monitor the application's status and performance.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "The App Service lacks a health check configuration. Consider setting up a health check to monitor the application effectively.",
		"snippet": block, 
    }
}
