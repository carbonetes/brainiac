# METADATA
# title: "Verify public facing ALB are protected by WAF"
# description: "By enforcing this policy, organizations can enhance the security posture of their web applications and services."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb.html
# custom:
#   id: CB_TFAWS_325
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_325

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	valid_resources := ["aws_alb", "aws_lb"]
	label in valid_resources
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getalblabel contains label if {
	some resource in input
	resource.Type == "resource"
	valid_resources := ["aws_alb", "aws_lb"]
    some label_resource in resource.Labels
	label_resource in valid_resources
	label := concat(".", resource.Labels)
}

is_aws_waf_linked if {
	some resource in input
	resource.Type == "resource"
	valid_waf_resources := ["aws_wafregional_web_acl_association", "aws_wafv2_web_acl_association"]
	some label_resource in resource.Labels
	label_resource in valid_waf_resources
	some label in getalblabel
	contains(resource.Attributes.resource_arn, label)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_aws_waf_linked
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	validlb := ["network", "gateway"]
	resource.Attributes.load_balancer_type in validlb
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Public facing ALB are protected by WAF.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Public facing ALB should be protected by WAF.",
		"snippet": block,
	}
}
