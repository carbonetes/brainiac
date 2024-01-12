# METADATA
# title: "Verify that there are no access control groups permitting inbound traffic from the IP address 0.0.0.0 to port 80"
# description: "Verify that no access control groups permit inbound traffic from the IP address 0.0.0.0 to port 80, enhancing network security."
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/access_control_group_rule
# custom:
#   id: CB_TFNCP_024
#   severity: MEDIUM
package lib.terraform.CB_TFNCP_024

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"ncloud_access_control_group_rule" in block.Labels
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
	some inner_block in block.Blocks
	inner_block.Type == "inbound"
	inner_block.Attributes.to_port == "80"
	inner_block.Attributes.source_ip == "0.0.0.0/0"
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Access control groups are not permitting inbound traffic from the IP address 0.0.0.0 to port 80.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Access control groups must not permit inbound traffic from the IP address 0.0.0.0 to port 80.",
		"snippet": block,
	}
}
