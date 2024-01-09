# METADATA
# title: "An incoming Network Access Control List (NACL) rule must not permit traffic across all ports"
# description: "Verify that inbound Network Access Control Lists (NACLs) do not authorize traffic for all ports."
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/network_acl_rule
# custom:
#   id: CB_TFNCP_012
#   severity: MEDIUM
package lib.terraform.CB_TFNCP_012

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
    restricted_value := ["1-65535"]
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "inbound"
    some range in inner_block.Attributes.port_range
	range in restricted_value
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Network Access Control List (NACL) rule does not grant traffic across all ports.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Network Access Control List (NACL) rule must not grant traffic across all ports.",
		"snippet": block,
	}
}
