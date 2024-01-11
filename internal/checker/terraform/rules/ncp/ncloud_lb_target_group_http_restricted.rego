# METADATA
# title: "Verify that the Load Balancer Target Group does not employ HTTP as its protocol"
# description: "Confirm that the Load Balancer Target Group does not utilize the HTTP protocol, promoting a more secure configuration."
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/lb_target_group
# custom:
#   id: CB_TFNCP_015
#   severity: LOW
package lib.terraform.CB_TFNCP_015

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"ncloud_lb_target_group" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.protocol == "HTTP"
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Load Balancer Target Group does not utilize HTTP as its protocol.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Load Balancer Target Group must not utilize HTTP as its protocol.",
		"snippet": block,
	}
}
