# METADATA
# title: "Verify MultiCluster App ID for Rancher2 Global DNS"
# description: "Policy to verify MultiCluster App ID for Rancher2 Global DNS, which conflicts with project IDs."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/global_dns
# custom:
#   id: CB_TFRAN_125
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_125

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_global_dns" in block.Labels
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
	conflict_rule(block)
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.multi_cluster_app_id == ""
}

conflict_rule(block) {
	block.Attributes.project_ids
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "MultiCluster App ID for Rancher2 Global DNS successfully validated, ensuring compatibility with the specified parameters.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Global DNS configuration. Ensure that 'multi_cluster_app_id' is included and specified, considering the potential conflict with 'project_ids'.",
		"snippet": block,
	}
}
