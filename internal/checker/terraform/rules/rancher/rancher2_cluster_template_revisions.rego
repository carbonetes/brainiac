# METADATA
# title: "Verify Rancher2 Cluster Template Revisions"
# description: "Policy to verify Rancher2 Cluster Template configuration includes template_revisions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_template
# custom:
#   id: CB_TFRAN_121
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_121

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
	innerblock.Type == "template_revisions"
	"name" in object.keys(innerblock.Attributes)
	innerblock.Attributes.name == ""
}

fail[block] {
	some block in input
	isvalid(block)
	some innerblock in block.Blocks
	innerblock.Type == "template_revisions"
	some innerblock2 in innerblock.Blocks
	not innerblock2.Type == "cluster_config"
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Cluster Template configuration successfully validated with included template_revisions, as well as the name and cluster config.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Cluster Template configuration. Ensure that within 'template_revisions', both 'name' and 'cluster_config' are required fields.",
		"snippet": block,
	}
}
