# METADATA
# title: "Verify if WAF Prevents Message Lookup in Log4j2. See CVE-2021-44228, aka log4jshell, for more information."
# description: "Using an outdated Apache Log4j library could allow attackers to exploit a Lookup mechanism, enabling requests with special syntax in a format string and posing risks like code execution and data leakage."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-wafv2-webacl.html
# custom:
#   id: CB_CFT_115
#   severity: CRITICAL
package lib.cloudformation.CB_CFT_115

import future.keywords.in

resource := "AWS::WAFv2::WebACL"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

fail[block] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	some block in resources.Properties.Rules
	statement := block.Statement.ManagedRuleGroupStatement
	statement.Name == "AWSManagedRulesKnownBadInputsRuleSet"
	some excluded_rule in statement.ExcludedRules
	excluded_rule.Name == "Log4JRCE"
}

pass[resources] {
	some resources in input.Resources
	is_valid
	count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "AWS WAF prevents message lookup in Log4j2.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "AWS WAF does not prevent message lookup in Log4j2.",
		"snippet": block,
	}
}
