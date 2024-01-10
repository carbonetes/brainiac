# METADATA
# title: "Make certain that a route table is established for the public subnets"
# description: "Verify that there exists a route table specifically designed for the public subnets within the network configuration. This assures proper routing for public-facing components."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/data-sources/subnet
# custom:
#   id: CB_TFNCP_020
#   severity: MEDIUM
package lib.terraform.CB_TFNCP_020

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"ncloud_route_table_association" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_ncloud_route_table[label] {
	some block in input
	block.Type == "resource"
	"ncloud_route_table" in block.Labels
	label := concat(".", block.Labels)
	block.Attributes.supported_subnet_type == "PUBLIC"
}

label_for_ncloud_subnet[label] {
	some block in input
	block.Type == "resource"
	"ncloud_subnet" in block.Labels
	label := concat(".", block.Labels)
	block.Attributes.subnet_type == "PUBLIC"
}

ncloud_route_table_and_ncloud_subnet_is_attached {
	some block in input
	block.Type == "resource"
	"ncloud_route_table_association" in block.Labels
	some label_route_table in label_for_ncloud_route_table
	contains(block.Attributes.route_table_id, label_route_table)
	some label_subnet in label_for_ncloud_subnet
	contains(block.Attributes.subnet_id, label_subnet)
}

pass[block] {
	some block in input
	isvalid(block)
	ncloud_route_table_and_ncloud_subnet_is_attached
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The route table is developed for the public subnets.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The route table must be developed for the public subnets.",
		"snippet": block,
	}
}
