# METADATA
# title: "Verify that Azure Front Door utilizes WAF in either Detection or Prevention modes"
# description: "Confirm that Azure Front Door employs Web Application Firewall (WAF) in either Detection or Prevention modes"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/frontdoor_firewall_policy
# custom:
#   id: CB_TFAZR_126
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_126

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_frontdoor_firewall_policy" in block.Labels
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
		"message": "Azure Front Door utilizes WAF in either 'Detection' or 'Prevention' modes.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Front Door does not utilize WAF in either 'Detection' or 'Prevention' modes.",
		"snippet": block,
	}
}
