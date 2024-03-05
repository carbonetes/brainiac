# METADATA
# title: "Verify Rancher2 Cluster Alert Group Recipients"
# description: "Policy to ensure that the Rancher2 Cluster Alert Group configuration includes recipients."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_alert_group
# custom:
#   id: CB_TFRAN_105
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_105

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_cluster_alert_group" in block.Labels
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
	some innerblock in block.Blocks
	innerblock.Type == "recipients"
	"notifier_id" in object.keys(innerblock.Attributes)
	innerblock.Attributes.notifier_id == ""
}

passed[result] {
	some block in pass
	result := {
		"message": "All Rancher2 Cluster Alert Group configurations include recipients.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Some Rancher2 Cluster Alert Group configurations are missing recipients. Please ensure recipients are provided.",
		"snippet": block,
	}
}
