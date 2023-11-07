# METADATA
# title: "Verify that the default service account is not employed at the organizational level"
# description: "Confirm that the default service account is not utilized at the organizational level to maintain a secure environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_organization_iam#google_organization_iam_binding
# custom:
#   id: CB_TFGCP_018
#   severity: CRITICAL
package lib.terraform.CB_TFGCP_018

import future.keywords.in

isvalid(block) {
	supported_resources := ["google_organization_iam_binding", "google_organization_iam_member"]
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
		"message": "The default service account is not utilized at the organizational level.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The default service account must not be utilized at the organizational level.",
		"snippet": block,
	}
}
