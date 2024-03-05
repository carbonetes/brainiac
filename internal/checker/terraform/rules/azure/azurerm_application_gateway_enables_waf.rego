# METADATA
# title: "Verify that Application Gateway has Web Application Firewall (WAF) enabled"
# description: "Ensure that Application Gateway is configured with Web Application Firewall (WAF) enabled to provide an additional layer of security against web application attacks"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy
# custom:
#   id: CB_TFAZR_123
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_123

import future.keywords.in

supportedResources := ["azurerm_application_gateway", "azurerm_web_application_firewall_policy"]

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
		"message": "Application Gateway has Web Application Firewall (WAF) enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Application Gateway does not have Web Application Firewall (WAF) enabled.",
		"snippet": block,
	}
}
