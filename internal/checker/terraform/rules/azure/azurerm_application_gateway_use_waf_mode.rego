# METADATA
# title: "Verify that Application Gateway utilizes WAF in either Detection or Prevention modes"
# description: "Ensure that Application Gateway uses WAF in either Detection or Prevention modes by verifying the enabled state of the Web Application Firewall (WAF) policy"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy
# custom:
#   id: CB_TFAZR_125
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_125

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_web_application_firewall_policy" in block.Labels
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
	some innerblock in resource.Blocks
	innerblock.Type == "policy_settings"
	innerblock.Attributes.enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Application Gateway utilizes WAF in either 'Detection' or 'Prevention' modes.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Application Gateway does not utilize WAF in either 'Detection' or 'Prevention' modes.",
		"snippet": block,
	}
}
