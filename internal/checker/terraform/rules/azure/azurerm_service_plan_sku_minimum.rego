# METADATA
# title: "Verify App Service Plan Production Suitability"
# description: "This policy verifies whether the chosen App Service Plan is suitable for production use by examining its configuration and settings."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan
# custom:
#   id: CB_TFAZR_209
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_209

import future.keywords.if
import future.keywords.in

supportedResources := ["azurerm_service_plan"]

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
	not forbiddenValues(resource.Attributes.sku_name)
}

forbiddenValues(sku_name) if {
	sku_name == "B1"
} else if {
	sku_name == "B2"
} else if {
	sku_name == "B3"
} else if {
	sku_name == "F1"
} else if {
	sku_name == "D1"
}


fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {"message": "The selected App Service Plan is suitable for production use."}
}

failed[result] {
	some block in fail
	result := {"message": "The chosen App Service Plan may not be suitable for production use. Review the configuration to ensure it meets production requirements."}
}
