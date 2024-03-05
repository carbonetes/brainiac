# METADATA
# title: "Verify Rancher2 Cluster Template Members"
# description: "Policy to verify Rancher2 Cluster Template configuration includes members."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_template
# custom:
#   id: CB_TFRAN_120
#   severity: LOW
package lib.terraform.CB_TFRAN_120

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_cluster_template" in block.Labels
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
	some innerblock in block.Blocks
	innerblock.Type == "members"
	"access_type" in object.keys(innerblock.Attributes)
	not innerblock.Attributes.access_type in ["read-only", "owner"]
}

fail[block] {
	some block in input
	isvalid(block)
	some innerblock in block.Blocks
	innerblock.Type == "members"
	"user_principal_id" in object.keys(innerblock.Attributes)
	innerblock.Attributes.user_principal_id == ""
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Cluster Template configuration successfully validated with included members.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Cluster Template configuration. Ensure that members are included to meet configuration requirements.",
		"snippet": block,
	}
}
