# METADATA
# title: "Verify WAF2 has a Logging Configuration"
# description: "By verifying the presence of a logging configuration, organizations can enhance their security posture by having a comprehensive view of potential threats and taking proactive measures to protect their applications and systems."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl.html
# custom:
#   id: CB_TFAWS_334
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_334

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_wafv2_web_acl"
}

getWafV2Label[label]{
    resource := input[_]
	resource.Type == "resource"
    resource.Labels[_] == "aws_wafv2_web_acl"
    label := concat(".", resource.Labels)
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

isAttachementValid{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_wafv2_web_acl_logging_configuration"
    contains(resource.Attributes.resource_arn, getWafV2Label[_])
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    isAttachementValid
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "WAF2 has a Logging Configuration.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "WAF2 should have a Logging Configuration.",
                "snippet": block }
} 