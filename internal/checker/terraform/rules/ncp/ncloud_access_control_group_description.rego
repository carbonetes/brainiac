# METADATA
# title: "Make certain that each rule in the access control groups is accompanied by a description"
# description: "Confirm that every access control group rule is accompanied by a distinctive description to provide clarity and understanding of its purpose and function."
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/data-sources/access_control_group
# custom:
#   id: CB_TFNCP_002
#   severity: MEDIUM
package lib.terraform.CB_TFNCP_002

import future.keywords.in

isvalid(block) {
	supported_resources := ["ncloud_access_control_group", "ncloud_access_control_group_rule"]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
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
	"description" in object.keys(block.Attributes)
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Each rule in the access control groups is accompanied by a description.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Each rule in the access control groups must be accompanied by a description.",
		"snippet": block,
	}
}
