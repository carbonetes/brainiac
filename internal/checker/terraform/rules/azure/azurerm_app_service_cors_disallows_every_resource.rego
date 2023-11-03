# METADATA
# title: "Make certain that Cross-Origin Resource Sharing (CORS) restricts access for all resources attempting to connect with app services"
# description: "Implement stringent CORS policies to enforce comprehensive access restrictions, ensuring that app services remain shielded from unauthorized resource access. These policies will help safeguard the integrity and security of your app services by limiting external interactions to authorized sources only."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# custom:
#   id: CB_TFAZR_049
#   severity: LOW
package lib.terraform.CB_TFAZR_049

import future.keywords.in

supportedResources := ["azurerm_app_service", "azurerm_linux_web_app", "azurerm_windows_web_app"]

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

fail[block] {
	some block in input
	isvalid(block)
	some innerBlock in block.Blocks
    innerBlock.Type == "site_config"
	some innermostBlock in innerBlock.Blocks
	innermostBlock.Type == "cors"
	"*" in innermostBlock.Attributes.allowed_origins
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Cross-Origin Resource Sharing (CORS) restricts access for all resources attempting to connect with app services.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Cross-Origin Resource Sharing (CORS) must restrict access for all resources attempting to connect with app services.",
		"snippet": block,
	}
}