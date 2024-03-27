# METADATA
# title: "See to it that ALB shifts HTTP requests to HTTPS requests"
# description: "Verify that the load balancer reroutes any traffic coming from the encrypted endpoint instead of performing it over http or no reactivity at all."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
# custom:
#   id: CB_TFAWS_366
#   severity: LOW
package lib.terraform.CB_TFAWS_366

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resources := ["aws_alb", "aws_lb"]
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

getthelabelforalb contains label if {
	some resource in input
	resource.Type == "resource"
	supported_resources := ["aws_alb", "aws_lb"]
	some label_resource in resource.Labels
	label_resource in supported_resources
	label := concat(".", resource.Labels)
}

has_invalid_listener_connections if {
	some resource in input
	resource.Type == "resource"
	valid_listeners := ["aws_alb_listener", "aws_lb_listener"]
	some label_resource in resource.Labels
	label_resource in valid_listeners
	some label in getthelabelforalb
	contains(resource.Attributes.load_balancer_arn, label)
	resource.Attributes.port == "80"
	resource.Attributes.protocol == "HTTP"
	not hasValidDefaultAction(resource)
}

hasValidDefaultAction(resource) if {
	some block in resource.Blocks
	block.Type == "default_action"
	block.Attributes.type == "redirect"
	some inner_block in block.Blocks
	inner_block.Type == "redirect"
	inner_block.Attributes.port == "443"
	inner_block.Attributes.protocol == "HTTPS"
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	has_invalid_listener_connections
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "The ALB shifts HTTP requests to HTTPS requests.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "The ALB must shift HTTP requests to HTTPS requests.",
		"snippet": block,
	}
}
