# METADATA
# title: "Verify Checksum and Whitelist Domain Configuration for Rancher2 Cluster Driver"
# description: "Policy to ensure Rancher2 Cluster Driver Checksum and Whitelist Domain configuration aligns with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_driver
# custom:
#   id: CB_TFRAN_116
#   severity: LOW
package lib.terraform.CB_TFRAN_116

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
	block.Attributes.checksum == ""
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.whitelist_domains == []
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Checksum and Whitelist Domain Configuration for Rancher2 Cluster Driver successfully verified, meeting specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Checksum and Whitelist Domain Configuration for Rancher2 Cluster Driver.  Please ensure valid entries are provided where necessary to meet configuration requirements.",
		"snippet": block,
	}
}
