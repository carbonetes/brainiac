# METADATA
# title: "Verify that WAF is in compliance with all applicable rules"
# description: "AWS WAF is a protective shield for web applications, aiming to defend against potential attacks. By customizing rules, you can utilize AWS WAF to authorize, restrict, or monitor web requests based on specific conditions you set. These conditions include factors like IP addresses, HTTP headers, HTTP body content, URI strings, and safeguarding against common vulnerabilities such as SQL injection and cross-site scripting, ensuring enhanced web application security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl.html
# custom:
#   id: CB_TFAWS_163
#   severity: LOW
package lib.terraform.CB_TFAWS_163
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    supported_resources := ["aws_waf_web_acl", "aws_wafregional_web_acl", "aws_wafv2_web_acl"]
    label in supported_resources
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
    valid_types := ["rule", "rules"]
    some block in resource.Blocks
    block.Type in valid_types
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "WAF is in compliance with all applicable rules.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "WAF must be in compliance with all applicable rules.",
                "snippet": block }
}