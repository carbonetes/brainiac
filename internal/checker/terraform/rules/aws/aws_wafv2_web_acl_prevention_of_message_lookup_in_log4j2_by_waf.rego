# METADATA
# title: "Ensures that WAF blocks Log4j2 message lookup. Take a look at CVE-2021-44228, also known as log4jshell"
# description: "Attackers may be able to take advantage of the Lookup mechanism, which permits making requests using specific syntax in a format string, by using an insecure version of the Apache Log4j library. This might result in dangerous code execution, data leaking, and other things."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl.html
# custom:
#   id: CB_TFAWS_183
#   severity: CRITICAL
package lib.terraform.CB_TFAWS_183
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_wafv2_web_acl"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 


pass contains resource if {
    some resource in input
	isvalid(resource)
    some block_one_rule in resource.Blocks
    block_one_rule.Type == "rule"
    some block_two_override in block_one_rule.Blocks
    block_two_override.Type == "override_action"
    some block_three_none in block_two_override.Blocks
    block_three_none.Type == "none"
    some block_two_statement in block_one_rule.Blocks
    block_two_statement.Type == "statement"
    some block_three_manage in block_two_statement.Blocks
    block_three_manage.Type == "managed_rule_group_statement"
    block_three_manage.Attributes.name == "AWSManagedRulesKnownBadInputsRuleSet"
    some block_four in block_three_manage.Blocks
    block_four.Type == "excluded_rule"
    block_four.Attributes.name != "Log4JRCE"
 }

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Log4j2 message lookup successfully blocked by WAF.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Log4j2 message lookup must be blocked by WAF.",
                "snippet": block }
} 