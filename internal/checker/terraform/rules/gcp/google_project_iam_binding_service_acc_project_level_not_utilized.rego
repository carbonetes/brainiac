# METADATA
# title: "Verify that the Default Service Account is not being employed within a project-level context"
# description: "Confirm that the Default Service Account is not being utilized at the project level to enhance security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_member
# custom:
#   id: CB_TFGCP_016
#   severity: CRITICAL
package lib.terraform.CB_TFGCP_016

import future.keywords.in

isvalid(block) {
	supported_resources := ["google_project_iam_member", "google_project_iam_binding"]
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
	invalid_member := [
		"project-number-compute@developer.gserviceaccount.com",
		"project-id@appspot.gserviceaccount.com",
	]
	block.Attributes.member in invalid_member
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Default Service Account is not being utilized at the project level.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Default Service Account must not be utilized at the project level.",
		"snippet": block,
	}
}
