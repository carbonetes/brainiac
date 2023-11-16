# METADATA
# title: "Verify that fundamental roles are not employed at the folder level"
# description: "Confirm that essential roles are not utilized within the context of folders."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_folder_iam#google_folder_iam_binding
# custom:
#   id: CB_TFGCP_079
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_079

import future.keywords.in

isvalid(block) {
	supported_resources := ["google_folder_iam_binding", "google_folder_iam_member"]
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
		"roles/editor",
		"roles/viewer",
		"roles/owner",
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
		"message": "The fundamental roles are not utilized at the folder level.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The fundamental roles must not be utilized at the folder level.",
		"snippet": block,
	}
}
