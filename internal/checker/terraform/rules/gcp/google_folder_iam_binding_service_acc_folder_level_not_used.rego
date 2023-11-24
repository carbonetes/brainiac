# METADATA
# title: "Verify that the default service account is not employed at the folder level"
# description: "Confirm that the default service account is not utilized within the folder context to assure security and compliance."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_folder_iam#google_folder_iam_binding
# custom:
#   id: CB_TFGCP_022
#   severity: CRITICAL
package lib.terraform.CB_TFGCP_022

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
		"message": "The default service account is not utilized within the folder level.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The default service account must not be utilized within the folder.",
		"snippet": block,
	}
}
