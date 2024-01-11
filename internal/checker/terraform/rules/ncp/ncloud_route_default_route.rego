# METADATA
# title: "Verify that the routing table linked to the Web tier subnet includes a default route (0.0.0.0/0) configuration to enable connectivity"
# description: "Confirm that the routing table connected to the Web tier subnet is configured with a default route (0.0.0.0/0) to facilitate network connectivity."
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/route
# custom:
#   id: CB_TFNCP_019
#   severity: MEDIUM
package lib.terraform.CB_TFNCP_019

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"ncloud_route" in block.Labels
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
	block.Attributes.destination_cidr_block == "0.0.0.0/0"
	block.Attributes.target_type == "NATGW"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The routing table attached to the Web tier subnet has been configured with a default route (0.0.0.0/0) to enable connectivity.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The routing table attached to the Web tier subnet must be configured with a default route (0.0.0.0/0) to enable connectivity.",
		"snippet": block,
	}
}
