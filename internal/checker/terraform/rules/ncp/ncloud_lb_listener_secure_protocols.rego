# METADATA
# title: "Guarantee that the Load Balancer (LB) Listener exclusively employs secure protocols"
# description: "Confirm that the Load Balancer (LB) Listener is configured to utilize secure protocols exclusively. This check assures that the protocols employed are resistant to security vulnerabilities, contributing to a more robust network infrastructure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/lb_listener
# custom:
#   id: CB_TFNCP_013
#   severity: MEDIUM
package lib.terraform.CB_TFNCP_013

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"ncloud_lb_listener" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
	some block in input
	isvalid(block)
	protocols := [
		"HTTPS",
		"TLS",
	]
	block.Attributes.protocol in protocols
	block.Attributes.tls_min_version_type == "TLSV12"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Load Balancer (LB) Listener is utilizing secure protocols.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Load Balancer (LB) Listener must utilize secure protocols.",
		"snippet": block,
	}
}
