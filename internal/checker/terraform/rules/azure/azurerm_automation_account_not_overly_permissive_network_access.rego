# METADATA
# title: "Verify Azure Automation Account Has Secure Network Access"
# description: "This policy verifies that Azure Automation Accounts do not have overly permissive network access configurations, which could pose security risks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_account
# custom:
#   id: CB_TFAZR_221
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_221

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"azurerm_automation_account" in resource.Labels
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
	resource.Attributes.public_network_access_enabled == false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Automation Account has secure network access.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Automation Account has overly permissive network access.",
		"snippet": block,
	}
}