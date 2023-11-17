# METADATA
# title: "Verify that fundamental roles are not employed at the project level"
# description: "Confirm that essential roles are not utilized at the project level."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_binding
# custom:
#   id: CB_TFGCP_083
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_083

import future.keywords.in

isvalid(block) {
	supported_resources := ["google_project_iam_binding", "google_project_iam_member"]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
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
	basic_roles := [
		"roles/owner",
		"roles/editor",
		"roles/viewer",
	]
	block.Attributes.role in basic_roles
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The fundamental roles are not utilized at the project level.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The fundamental roles must not be utilized at the project level.",
		"snippet": block,
	}
}
