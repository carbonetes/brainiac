# METADATA
# title: "Verify that the load balancer is utilizing at least TLS 1.2"
# description: "Between your load balancer and the clients who start SSL or TLS sessions, the HTTPS listener provides traffic encryption."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/elasticloadbalancing/latest/network/create-tls-listener.html
# custom:
#   id: CB_TFAWS_065
#   severity: HIGH
package lib.terraform.CB_TFAWS_065

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := ["aws_lb", "aws_lb_listener", "aws_alb_listener"]
	label in supportedresource
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
	protocolcheck := ["TCP", "UDP", "TCP_UDP"]
	some block in input
	isvalid(block)
	block.Attributes.protocol in protocolcheck
}

pass contains block if {
	protocolcheck := ["HTTPS", "TLS"]
	sslpolicycheck := ["ELBSecurityPolicy-FS-1-2", "ELBSecurityPolicy-TLS-1-2", "ELBSecurityPolicy-TLS13"]
	some block in input
	isvalid(block)
	block.Attributes.protocol in protocolcheck
	sslpolicy := block.Attributes.ssl_policy
    some policyvalue in sslpolicycheck
	startswith(sslpolicy, policyvalue)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "TLS 1.2 is being utilized by load balancer.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "TLS 1.2 should be utilized by load balancer.",
		"snippet": block,
	}
}
