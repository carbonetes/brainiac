# METADATA
# title: "Confirm that the App Service has Azure Defender enabled"
# description: "Verify the activation of Azure Defender for the App Service to bolster security, providing comprehensive protection against potential threats and vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing
# custom:
#   id: CB_TFAZR_098
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_098

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_security_center_subscription_pricing" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.resource_type != "AppServices"
}

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.tier == "Standard"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The App Service has Azure Defender enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": " App Service has Azure Defender disabled, it must be enabled.",
		"snippet": block,
	}
}
