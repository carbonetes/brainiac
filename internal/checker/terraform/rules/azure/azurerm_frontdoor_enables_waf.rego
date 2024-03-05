# METADATA
# title: "Verify that Azure Front Door has Web Application Firewall (WAF) enabled"
# description: "This policy checks whether Azure Front Door has Web Application Firewall (WAF) enabled, ensuring an additional layer of security for web applications"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/frontdoor
# custom:
#   id: CB_TFAZR_124
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_124

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_frontdoor" in block.Labels
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
	innerblock.Type == "frontend_endpoint"
	innerblock.Attributes.web_application_firewall_policy_link_id != null
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Front Door has Web Application Firewall (WAF) enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Front Door does not have Web Application Firewall (WAF) enabled.",
		"snippet": block,
	}
}
