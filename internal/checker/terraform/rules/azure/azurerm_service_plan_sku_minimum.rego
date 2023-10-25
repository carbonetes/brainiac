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

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_service_plan" in block.Labels
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
	not forbidden_values(resource.Attributes.sku_name)
}

forbidden_values("B1")

forbidden_values("B2")

forbidden_values("B3")

forbidden_values("F1")

forbidden_values("D1")

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The selected App Service Plan is suitable for production use.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The chosen App Service Plan may not be suitable for production use. Review the configuration to ensure it meets production requirements.",
		"snippet": block,
	}
}
