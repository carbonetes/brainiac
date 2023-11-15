# METADATA
# title: "Confirm that standard roles are not employed at the organization level"
# description: "Verify that commonly used roles are not assigned at the organizational level to maintain proper security measures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_organization_iam#google_organization_iam_binding
# custom:
#   id: CB_TFGCP_067
#   severity: LOW
package lib.terraform.CB_TFGCP_067

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
	invalid_role := [
		"roles/owner",
		"roles/viewer",
	]
	block.Attributes.role in invalid_role
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The standard roles are not assigned at the organization level.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The standard roles must not be assigned at the organization level.",
		"snippet": block,
	}
}
