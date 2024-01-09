# METADATA
# title: "Confirm that there are no access control groups permitting inbound traffic from IP address 0.0.0.0 on port 22"
# description: "Verify that there are no configurations in the access control groups that authorize incoming traffic from the IP address 0.0.0.0 to port 22."
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/access_control_group_rule
# custom:
#   id: CB_TFNCP_004
#   severity: MEDIUM
package lib.terraform.CB_TFNCP_004

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
	restricted_values := ["0.0.0.0/0", "::/0"]
	some inner_block in block.Blocks
	inner_block.Type == "inbound"
	inner_block.Attributes.to_port == "22"
	some restricted in inner_block.Attributes.cidr_block
	restricted in restricted_values
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "There are no access control groups permitting inbound traffic from IP address 0.0.0.0 on port 22.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Access control groups must not permit inbound traffic from IP address 0.0.0.0 on port 22.",
		"snippet": block,
	}
}
