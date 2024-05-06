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

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_wafv2_web_acl"
}

getwafv2label contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_wafv2_web_acl" in resource.Labels
	label := concat(".", resource.Labels)
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

is_attachment_valid if {
	some resource in input
	resource.Type == "resource"
	"aws_wafv2_web_acl_logging_configuration" in resource.Labels
	some label in getwafv2label
	contains(resource.Attributes.resource_arn, label)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_attachment_valid
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "WAF2 has a Logging Configuration.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "WAF2 should have a Logging Configuration.",
		"snippet": block,
	}
}
