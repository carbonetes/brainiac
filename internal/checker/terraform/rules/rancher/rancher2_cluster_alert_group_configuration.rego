# METADATA
# title: "Verify Rancher2 Cluster Alert Group Configuration"
# description: "Policy to ensure that the Rancher2 Cluster Alert Group configuration is provided with necessary parameters."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_alert_group
# custom:
#   id: CB_TFRAN_069
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_069

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
	block.Attributes.cluster_id != ""
	block.Attributes.name != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "All Rancher2 Cluster Alert Group configurations are valid.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Some Rancher2 Cluster Alert Group configurations are invalid. Please ensure all required fields are provided.",
		"snippet": block,
	}
}
