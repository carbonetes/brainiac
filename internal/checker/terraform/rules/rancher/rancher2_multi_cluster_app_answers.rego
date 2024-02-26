# METADATA
# title: "Verify Rancher2 Multi Cluster App Answers"
# description: "Policy to ensure that Rancher2 Multi Cluster App includes answers."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/multi_cluster_app
# custom:
#   id: CB_TFRAN_140
#   severity: LOW
package lib.terraform.CB_TFRAN_140

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

fail[block] {
	some block in input
	isvalid(block)
	some innerblock in block.Blocks
	innerblock.Type == "answers"
	innerblock.Attributes.project_id == ""
}

fail[block] {
	some block in input
	isvalid(block)
	some innerblock in block.Blocks
	innerblock.Type == "answers"
	is_object(innerblock.Attributes.values)
    count(innerblock.Attributes.values) == 0
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Multi Cluster App answers have been successfully validated and are included as specified.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Multi Cluster App configuration. Ensure that 'answers' are provided and included as specified.",
		"snippet": block,
	}
}
