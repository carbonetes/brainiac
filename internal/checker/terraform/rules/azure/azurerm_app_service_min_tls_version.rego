# METADATA
# title: "Make sure that the web app is employing the most up-to-date version of TLS encryption"
# description: "Confirm that your web application is utilizing the latest TLS encryption version to ensure enhanced security for data transmission"
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# custom:
#   id: CB_TFAZR_060
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_060

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
	to_number(innerBlock.Attributes.min_tls_version) >= 1.0
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "Your web app is successfully using the latest TLS encryption version, ensuring optimal security for data transmission.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Your web app is not using the latest TLS encryption version. Please update it to ensure optimal security for data transmission.",
		"snippet": block,
    }
}