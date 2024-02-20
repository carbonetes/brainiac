# METADATA
# title: "Verify Rancher2 Cluster Template Configuration"
# description: "Policy ensuring validation of Rancher2 Cluster Template configuration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_template
# custom:
#   id: CB_TFRAN_075
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_075

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

pass[block] {
	some block in input
	isvalid(block)
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
		"message": "Rancher2 Cluster Template configuration successfully verified for compliance with policy requirements.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Cluster Template configuration due to empty name field. Please provide a valid name to comply with policy requirements.",
		"snippet": block,
	}
}
