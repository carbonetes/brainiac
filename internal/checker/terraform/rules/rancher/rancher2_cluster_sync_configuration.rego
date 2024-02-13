# METADATA
# title: "Verify Rancher2 Cluster Sync Configuration"
# description: "Policy ensuring validation of Rancher2 Cluster Sync configuration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_sync
# custom:
#   id: CB_TFRAN_074
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_074

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

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.cluster_id != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Cluster Sync configuration successfully verified for compliance with policy standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure to meet Rancher2 Cluster Sync configuration standards detected. Adjust configuration settings to comply with policy requirements.",
		"snippet": block,
	}
}
