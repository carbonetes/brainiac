# METADATA
# title: "Verify Wait Configurations in Rancher2 Cluster Sync"
# description: "Policy to verify Wait Configurations in Rancher2 Cluster Sync for compliance with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_sync
# custom:
#   id: CB_TFRAN_118
#   severity: LOW
package lib.terraform.CB_TFRAN_118

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
	block.Attributes.wait_alerting != false
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.wait_catalogs != false
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.wait_monitoring != false
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Wait Configurations in Rancher2 Cluster Sync have been successfully verified. The options include wait_alerting, wait_catalogs, and wait_monitoring. Defaults are set to false.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Cluster Sync Wait Configurations. Ensure that the options such as wait_alerting, wait_catalogs, and wait_monitoring are correctly defined and configured.",
		"snippet": block,
	}
}
