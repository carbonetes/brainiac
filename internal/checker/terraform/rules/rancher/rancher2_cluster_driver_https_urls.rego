# METADATA
# title: "Verify Rancher2 Cluster Driver URLs uses HTTPS"
# description: "Policy to ensure Rancher2 Cluster Driver URLs configuration is using HTTPS"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_driver
# custom:
#   id: CB_TFRAN_115
#   severity: LOW
package lib.terraform.CB_TFRAN_115

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_cluster_driver" in block.Labels
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
	not startswith(block.Attributes.ui_url, "https://")
}

fail[block] {
	some block in input
	isvalid(block)
	not startswith(block.Attributes.actual_url, "https://")
}

fail[block] {
	some block in input
	isvalid(block)
	not startswith(block.Attributes.url, "https://")
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Cluster Driver URLs uses HTTPS",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher2 Cluster Driver configurations failed, URLs must use HTTPS. Update the configuration accordingly.",
		"snippet": block,
	}
}
