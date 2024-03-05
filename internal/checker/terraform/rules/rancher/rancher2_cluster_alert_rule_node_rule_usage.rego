# METADATA
# title: "Validate Rancher2 Cluster Alert Rule Node Rule Usage"
# description: "Policy to ensure that Rancher2 Cluster Alert Rule configurations include valid node rule."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_alert_rule
# custom:
#   id: CB_TFRAN_108
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_108

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_cluster_alert_rule" in block.Labels
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
	not node_rule(block)
}

fail[block] {
	some block in input
	isvalid(block)
	count(block.Blocks) == 1
	some innerblock in block.Blocks
	not innerblock.Type == "node_rule"
}

node_rule(block) {
	conflict_rule := [
		"event_rule",
		"metric_rule"
	]
	some innerblock in block.Blocks
	innerblock.Type == "node_rule"
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
		"message": "Rancher2 Cluster Alert Rule Node Rule is correctly configured.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher2 Cluster Alert Rule configurations include invalid or missing node rules.",
		"snippet": block,
	}
}
