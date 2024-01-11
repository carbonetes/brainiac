# METADATA
# title: "Guarantee that the Load Balancer Listener is configured to use the HTTPS protocol"
# description: "erify that the Load Balancer Listener is specifically configured to utilize the HTTPS protocol, enhancing the security of communication."
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/lb_listener
# custom:
#   id: CB_TFNCP_023
#   severity: LOW
package lib.terraform.CB_TFNCP_023

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
	block.Attributes.protocol == "HTTPS"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Load Balancer Listener is utilizing the HTTPS protocol.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Load Balancer Listener must utilize the HTTPS protocol.",
		"snippet": block,
	}
}
