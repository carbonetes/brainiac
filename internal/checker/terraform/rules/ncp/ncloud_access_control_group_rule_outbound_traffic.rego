# METADATA
# title: "Prevent security group rules from permitting outbound traffic to the IP address range 0.0.0.0/0"
# description: "This check confirms that no security group rules grant permission for outbound traffic to the IP address range 0.0.0.0/0. The purpose is to enhance network security by restricting outbound access to a more specific set of IP addresses, rather than allowing unrestricted communication to any destination."
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/access_control_group_rule
# custom:
#   id: CB_TFNCP_003
#   severity: LOW
package lib.terraform.CB_TFNCP_003

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
	inner_block.Type == "outbound"
	some restricted in inner_block.Attributes.ip_block
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
		"message": "No security group rules grant permission for outbound traffic to the IP address range 0.0.0.0/0 and ::/0.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Security groups rules must not grant permission for outbound traffic to the IP address range 0.0.0.0/0 and ::/0.",
		"snippet": block,
	}
}
