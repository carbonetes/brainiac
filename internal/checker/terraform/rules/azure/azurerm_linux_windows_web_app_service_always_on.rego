# METADATA
# title: "Verify Always On Setting for App Service"
# description: "This policy verifies that the App Service is configured to be 'always on' to ensure the continuous availability of the application."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app
# custom:
#   id: CB_TFAZR_212
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_212

import future.keywords.in

supportedResources := [
	"azurerm_linux_web_app",
	"azurerm_windows_web_app",
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
	block.Attributes.always_on == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The App Service is configured to be 'always on,' ensuring continuous availability.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "The App Service is not set to 'always on.' It is recommended to enable this setting to maintain application availability.",
		"snippet": block, 
    }
}
