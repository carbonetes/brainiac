# METADATA
# title: "Verify that the Front Door Web Application Firewall (WAF) is configured to block attempts to access messages in Log4j2. This vulnerability is referred to as CVE-2021-44228, commonly known as log4jshell"
# description: "Confirm that the Front Door Web Application Firewall (WAF) is set up to block unauthorized access to Log4j2 messages, addressing the vulnerability CVE-2021-44228, often referred to as log4jshell."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/frontdoor_firewall_policy
# custom:
#   id: CB_TFAZR_172
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_172

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

pass[block] {
	some block in input
	isvalid(block)
    expectedType := ["Microsoft_DefaultRuleSet","DefaultRuleSet"]
    expectedAction := ["Block", "Redirect"]
	some innerBlock in block.Blocks
    innerBlock.Type == "managed_rule"
    some innerBlock.Attributes.type in expectedType
	some innermostBlock in innerBlock.Blocks
	innermostBlock.Type == "override"
    innermostBlock.Attributes.rule_group_name == "JAVA"
    some ruleBlock in innermostBlock.Blocks
    ruleBlock.Type == "rule"
    some ruleBlock.Attributes.action in expectedAction
    ruleBlock.Attributes.enabled == true
    ruleBlock.Attributes.rule_id == "944240"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Front Door Web Application Firewall (WAF) is configured to block attempts to access messages in Log4j2.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Front Door Web Application Firewall (WAF) must be configured to block attempts to access messages in Log4j2.",
		"snippet": block,
	}
}