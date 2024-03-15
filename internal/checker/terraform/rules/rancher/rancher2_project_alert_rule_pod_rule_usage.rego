# METADATA
# title: "Verify Rancher2 Project Alert Rule Pod Rule Usage"
# description: "Policy to ensure that Rancher2 Project Alert Rule configurations include valid pod rule."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/project_alert_rule
# custom:
#   id: CB_TFRAN_177
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_177

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_project_alert_rule" in block.Labels
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
	not pod_rule(block)
}

fail[block] {
	some block in input
	isvalid(block)
	count(block.Blocks) == 1
	some innerblock in block.Blocks
	not innerblock.Type == "pod_rule"
}

pod_rule(block) {
	conflict_rule := [
		"metric_rule",
		"workload_rule",
	]
	some innerblock in block.Blocks
	innerblock.Type == "pod_rule"
	not innerblock.Type in conflict_rule
	count(block.Blocks) == 1
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Project Alert Rule Pod Rule is correctly configured.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher2 Project Alert Rule configurations include invalid or missing pod rules.",
		"snippet": block,
	}
}
