# METADATA
# title: "Verify HTTP HTTPS Target group defines Healthcheck"
# description: "This verification helps maintain the reliability and availability of the target instances by automatically removing unhealthy instances from the load balancer's routing pool."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/2.43.0/docs/resources/lb_target_group
# custom:
#   id: CB_TFAWS_254
#   severity: LOW
package lib.terraform.CB_TFAWS_254

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resources := ["aws_alb_target_group", "aws_lb_target_groupaws_lb_target_group"]
	label in supported_resources
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains block if {
	some block in input
	isvalid(block)
	protocols := ["HTTP", "HTTPS"]
	block.Attributes.protocol in protocols
	some health in block.Blocks
	health.Type == "health_check"
	health.Attributes.path != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "HTTP HTTPS Target group defines Healthcheck.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "HTTP HTTPS Target group Healthcheck must be define",
		"snippet": block,
	}
}
