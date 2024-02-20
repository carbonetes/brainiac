# METADATA
# title: "Verify Rancher2 Multi Cluster App Targets Configuration"
# description: "Policy to validate Rancher2 Multi Cluster App Configurations, ensuring the inclusion of target projects."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/multi_cluster_app
# custom:
#   id: CB_TFRAN_109
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_109

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_multi_cluster_app" in block.Labels
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
	some innerblock in block.Blocks
	innerblock.Type == "targets"
	innerblock.Attributes.project_id != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Successful validation confirms that Rancher2 Multi Cluster App Configurations include the specified target projects.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Validation failure indicates that Rancher2 Multi Cluster App Configurations lack the required inclusion of target projects. Please review and update the configurations accordingly.",
		"snippet": block,
	}
}
