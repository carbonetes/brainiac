# METADATA
# title: "Verify that ALB is configured with defensive or strictest desync mitigation mode"
# description: "This policy aims to ensure the secure configuration of the Application Load Balancer (ALB) by verifying that it is set to either the defensive or strictest desync mitigation mode. Desync attacks can pose significant security risks to web applications, exploiting discrepancies between front-end and back-end HTTP request parsing."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb.html
# custom:
#   id: CB_TFAWS_300
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_300

import rego.v1

isvalid(block) if {
    block.Type == "resource"
    supported_resources := ["aws_alb", "aws_elb", "aws_lb"]
    some label in block.Labels
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
	block.Attributes.routing_http_desync_mitigation_mode != "monitor"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "ALB is configured with defensive or strictest desync mitigation mode.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "ALB must be configured with defensive or strictest desync mitigation mode.",
		"snippet": block,
	}
}
