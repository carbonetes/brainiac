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

supportedResource := ["aws_alb", "aws_elb", "aws_lb"]

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == supportedResource[_]
}

resource[resource] {
	block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
	block := fail[_]
	resource := concat(".", block.Labels)
}

pass[block] {
	block := input[_]
	isvalid(block)
	block.Attributes.routing_http_desync_mitigation_mode != "monitor"
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "ALB is configured with defensive or strictest desync mitigation mode.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "ALB must be configured with defensive or strictest desync mitigation mode.",
		"snippet": block,
	}
}
