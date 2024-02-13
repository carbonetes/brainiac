# METADATA
# title: "Verify Rancher2 Cluster Alert Rule Configuration"
# description: "Policy to ensure that Rancher2 Cluster Alert Rule configurations include all essential parameters."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_alert_rule
# custom:
#   id: CB_TFRAN_071
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_071

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

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.cluster_id != ""
	block.Attributes.group_id != ""
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
		"message": "Successfully ensures all essential parameters are included in Rancher2 Cluster Alert Rule configurations.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Missing parameters found in Rancher2 Cluster Alert Rule configuration. Please ensure all required fields are provided.",
		"snippet": block,
	}
}
