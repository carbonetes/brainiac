# METADATA
# title: "Confirm that the web app uses the latest 'HTTP Version' if applicable"
# description: "Verify that the web application, when applicable, utilizes the most recent 'HTTP Version.' This involves ensuring that the web application is configured to use the latest available version of the HTTP protocol for communication"
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# custom:
#   id: CB_TFAZR_081
#   severity: LOW
package lib.terraform.CB_TFAZR_081

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
    innerBlock.Type == "site_config"
	innerBlock.Attributes.http2_enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The web app is confirmed to use the latest 'HTTP Version' where applicable.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The web app does not use the latest 'HTTP Version' when applicable.",
		"snippet": block,
	}
}
