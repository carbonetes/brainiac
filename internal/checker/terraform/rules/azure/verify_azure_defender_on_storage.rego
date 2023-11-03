# METADATA
# title: "Verify that Azure Defender is set to On for Storage"
# description: "This policy is designed to enhance the security and threat protection of Azure Storage accounts by verifying that Azure Defender is enabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing
# custom:
#   id: CB_TFAZR_076
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_076

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
	block.Attributes.resource_type != "StorageAccounts"
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
		"message": "Azure Defender is enabled for Storage.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Defender is disabled for Storage.",
		"snippet": block,
	}
}