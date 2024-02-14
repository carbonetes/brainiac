# METADATA
# title: "Confirm that the web application has the 'Client Certificates (Incoming client certificates)' configuration enabled"
# description: "Verify that the web application has the 'Client Certificates (Incoming client certificates)' setting activated"
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# custom:
#   id: CB_TFAZR_071
#   severity: LOW
package lib.terraform.CB_TFAZR_071

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
	resource.Attributes.client_cert_enabled == true
}

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.client_certificate_enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
        "message": "The web application has 'Client Certificates (Incoming client certificates)' configuration enabled",
		"snippet": block,
    }
}

failed[result] {
	some block in fail
	result := {
        "message": "The web application does not have 'Client Certificates (Incoming client certificates)' configuration enabled",
		"snippet": block,
    }
}
