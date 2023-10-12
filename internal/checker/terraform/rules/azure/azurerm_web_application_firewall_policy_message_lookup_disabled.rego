# METADATA
# title: "Verify that the Application Gateway Web Application Firewall (WAF) blocks attempts to access messages in Log4j2, addressing the vulnerability known as CVE-2021-44228, also referred to as log4jshell"
# description: "Confirm that the Application Gateway Web Application Firewall (WAF) safeguards against unauthorized access to Log4j2 messages, addressing the CVE-2021-44228 vulnerability, also known as log4jshell."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/web_application_firewall_policy
# custom:
#   id: CB_TFAZR_179
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_179

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

pass[block] {
	some block in input
	isvalid(block)
    expectedVersion := ["3.2", "3.1"]
	some innerBlock in block.Blocks
    innerBlock.Type == "managed_rules"
	some ruleSetBlock in innerBlock.Blocks
	ruleSetBlock.Type == "managed_rule_set"
    ruleSetBlock.Attributes.type == "OWASP"
    some ruleSetBlock.Attributes.version in expectedVersion
    some overrideBlock in innerBlock.Blocks
    overrideBlock.Type == "rule_group_override"
    "944240" in overrideBlock.Attributes.disabled_rules
    overrideBlock.Attributes.rule_group_name == "REQUEST-944-APPLICATION-ATTACK-JAVA"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Application Gateway Web Application Firewall (WAF) blocks attempts to access messages in Log4j2.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Application Gateway Web Application Firewall (WAF) must block attempts to access messages in Log4j2.",
		"snippet": block,
	}
}