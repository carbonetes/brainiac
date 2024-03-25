# METADATA
# title: "Verify ALB protocol is HTTPS"
# description: "Using plain HTTP for communication between the client and the load balancer means that the traffic is not encrypted, making it vulnerable to interception and eavesdropping."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
# custom:
#   id: CB_TFAWS_002
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_002

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := ["aws_alb_listener", "aws_lb_listener"]
	label in supportedresource
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in failedchecks
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	seccuredprotocol := ["HTTPS", "TLS", "TCP", "UDP", "TCP_UDP"]
	resource.Attributes.protocol in seccuredprotocol
}

failedchecks contains block if {
	some block in input
	isvalid(block)
	count(pass) == 0
}

passed contains result if {
	some block in pass
	result := {
		"message": "The ALB protocol should is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in failedchecks
	result := {
		"message": "The ALB protocol should is set to secure.",
		"snippet": block,
	}
}
