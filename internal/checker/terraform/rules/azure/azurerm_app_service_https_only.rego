# METADATA
# title: "Make sure the web app in Azure App Service directs all HTTP traffic to HTTPS"
# description: "Confirm that the web app redirects all HTTP traffic to HTTPS in Azure App Service for increased security and encryption"
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# custom:
#   id: CB_TFAZR_046
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_046

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
	resource.Attributes.https_only == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "HTTP to HTTPS redirection is properly configured for your web app. It enhances security and encrypts your traffic.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "HTTP to HTTPS redirection is not properly configured for your web app. Ensure it redirects all HTTP traffic to HTTPS for enhanced security and encryption.",
		"snippet": block,
	}
}
