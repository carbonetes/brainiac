# METADATA
# title: "Verify if WAF Prevents Message Lookup in Log4j2."
# description: "This policy advises against using vulnerable versions of the Apache Log4j library, which could enable attackers to exploit a Lookup mechanism. By setting your Web Application Firewall (WAF) to block the execution of such mechanisms, you can mitigate risks such as code execution and data leakage."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-wafv2-webacl.html
# custom:
#   id: CB_CFT_110
#   severity: CRITICAL
package lib.cloudformation.CB_CFT_110

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
