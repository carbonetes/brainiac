# METADATA
# title: "Verify that an Access Control Group is associated with an Access Control Group Rule"
# description: "Guarantee that each Access Control Group is linked to an Access Control Group Rule, enhancing network security by defining specific access policies. This check is categorized as 'NETWORKING."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/access_control_group_rule
# custom:
#   id: CB_TFNCP_025
#   severity: MEDIUM
package lib.terraform.CB_TFNCP_025

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

label_for_ncloud_access_control_group[label] {
	some block in input
	block.Type == "resource"
	"ncloud_access_control_group" in block.Labels
	label := concat(".", block.Labels)
}

ncloud_access_control_group_is_attached {
	some block in input
	block.Type == "resource"
	"ncloud_access_control_group_rule" in block.Labels
	some label in label_for_ncloud_access_control_group
	contains(block.Attributes.access_control_group_id, label)
}

pass[block] {
	some block in input
	isvalid(block)
	ncloud_access_control_group_is_attached
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Access Control Group is connected with an Access Control Group Rule.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Access Control Group must be connected with an Access Control Group Rule.",
		"snippet": block,
	}
}
