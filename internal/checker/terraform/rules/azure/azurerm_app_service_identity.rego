# METADATA
# title: "Make sure that Azure Active Directory registration is enabled for your App Service"
# description: "Activate Azure Active Directory registration on your Azure App Service, allowing it to integrate with Azure Active Directory for authentication and access control purposes"
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# custom:
#   id: CB_TFAZR_062
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_062

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
	innerBlock.Type == "identity"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Register with Azure Active Directory is enabled on App Service.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Register with Azure Active Directory is not enabled on App Service.",
		"snippet": block,
	}
}
