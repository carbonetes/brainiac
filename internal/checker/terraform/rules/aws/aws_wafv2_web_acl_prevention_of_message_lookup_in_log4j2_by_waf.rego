# METADATA
# title: "See to it that WAF blocks Log4j2 message lookup. Take a look at CVE-2021-44228, also known as log4jshell"
# description: "Attackers may be able to take advantage of the Lookup mechanism, which permits making requests using specific syntax in a format string, by using an insecure version of the Apache Log4j library. This might result in dangerous code execution, data leaking, and other things."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl.html
# custom:
#   id: CB_TFAWS_183
#   severity: CRITICAL
package lib.terraform.CB_TFAWS_183

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_wafv2_web_acl"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "rule"
    resource.Blocks[_].Blocks[_].Type == "override_action"
    resource.Blocks[_].Blocks[_].Blocks[_].Type == "none"
    resource.Blocks[_].Blocks[_].Type == "statement"
    resource.Blocks[_].Blocks[_].Blocks[_].Type == "managed_rule_group_statement"
    resource.Blocks[_].Blocks[_].Blocks[_].Attributes.name == "AWSManagedRulesKnownBadInputsRuleSet"
    resource.Blocks[_].Blocks[_].Blocks[_].Blocks[_].Type == "excluded_rule"
    resource.Blocks[_].Blocks[_].Blocks[_].Blocks[_].Attributes.name != "Log4JRCE"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Log4j2 message lookup successfully blocked by WAF.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Log4j2 message lookup must be blocked by WAF.",
                "snippet": block }
} 