# METADATA
# title: "Verify Rancher2 Project Alert Group Non-Zero Interval Seconds"
# description: "Policy to ensure that the Rancher2 Project Alert Group configuration specifies non-zero interval seconds."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/project_alert_group
# custom:
#   id: CB_TFRAN_111
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_111

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_project_alert_group" in block.Labels
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
	not fail[block]
}

fail[block] {
	some block in input
	isvalid(block)
	is_number(block.Attributes.group_interval_seconds) != false
	to_number(block.Attributes.group_interval_seconds) <= 0
}

fail[block] {
	some block in input
	isvalid(block)
	is_number(block.Attributes.group_wait_seconds) != false
	to_number(block.Attributes.group_wait_seconds) <= 0
}

fail[block] {
	some block in input
	isvalid(block)
	is_number(block.Attributes.repeat_interval_seconds) != false
	to_number(block.Attributes.repeat_interval_seconds) <= 0
}

passed[result] {
	some block in pass
	result := {
		"message": "All Rancher2 Project Alert Group has valid interval seconds.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Some Rancher2 Project Alert Group configurations have invalid interval seconds. Please ensure all interval seconds are set to non-zero values.",
		"snippet": block,
	}
}
