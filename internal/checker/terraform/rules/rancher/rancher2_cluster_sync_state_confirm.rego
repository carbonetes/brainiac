# METADATA
# title: "Verify Rancher2 Cluster Sync State Confirm is Non-Zero"
# description: "Policy to verify Rancher2 Cluster Sync configuration specifies non-zero value for state_confirm"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_sync
# custom:
#   id: CB_TFRAN_119
#   severity: LOW
package lib.terraform.CB_TFRAN_119

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_cluster_sync" in block.Labels
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
	is_number(block.Attributes.state_confirm) != false
	to_number(block.Attributes.state_confirm) <= 0
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "State confirmation in Rancher2 Cluster Sync has been successfully validated. The 'state_confirm' option is set to a non-zero value, ensuring active status confirmation.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Cluster Sync configuration. Ensure that the 'state_confirm' option is set to a non-zero value for active status confirmation.",
		"snippet": block,
	}
}
