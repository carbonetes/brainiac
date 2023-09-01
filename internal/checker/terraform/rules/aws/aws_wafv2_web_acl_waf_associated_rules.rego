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



supportedResources := ["aws_waf_web_acl", "aws_wafregional_web_acl", "aws_wafv2_web_acl"]
validTypes := ["rule", "rules"]
isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
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
    resource.Blocks[_].Type == validTypes[_]
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "WAF is in compliance with all applicable rules.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "WAF must be in compliance with all applicable rules.",
                "snippet": block }
} 