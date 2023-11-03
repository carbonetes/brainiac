# METADATA
# title: "Confirm that Azure SQL database servers have Azure Defender enabled"
# description: "Confirm that Azure Defender is activated for Azure SQL database servers, enhancing their security posture by safeguarding against potential threats and vulnerabilities. This proactive defense mechanism helps maintain the integrity and resilience of your database infrastructure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing
# custom:
#   id: CB_TFAZR_099
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_099

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
	block.Attributes.resource_type != "SqlServers"
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
		"message": "The Azure SQL database servers have Azure Defender enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Azure SQL database servers have Azure Defender disabled, it must be enabled.",
		"snippet": block,
	}
}
