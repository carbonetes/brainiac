# METADATA
# title: "Make certain that there are no Network Access Control Lists (NACLs) permitting inbound traffic from the IP address 0.0.0.0 to port 3389"
# description: "Verify that Network Access Control Lists (NACLs) do not authorize incoming traffic from the IP address 0.0.0.0 to port 3389."
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/network_acl_rule
# custom:
#   id: CB_TFNCP_011
#   severity: MEDIUM
package lib.terraform.CB_TFNCP_011

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"ncloud_network_acl_rule" in block.Labels
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
	inner_block.Attributes.to_port == "3389"
	inner_block.Attributes.ipv4_cidr == "0.0.0.0/0"
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Network Access Control Lists (NACLs) is not permitting inbound traffic from the IP address 0.0.0.0 to port 3389.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Network Access Control Lists (NACLs) must not permit inbound traffic from the IP address 0.0.0.0 to port 3389.",
		"snippet": block,
	}
}
