# METADATA
# title: "Verify that Service Account User and Service Account Token Creator roles are not allocated to IAM users at the project level"
# description: "Assure that IAM users are not designated with either the Service Account User or Service Account Token Creator roles at the project level to enhance security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam.html#google_project_iam_binding
# custom:
#   id: CB_TFGCP_003
#   severity: HIGH
package lib.terraform.CB_TFGCP_003

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

pass[block] {
	some block in input
	isvalid(block)
	invalid_roles := ["roles/iam.serviceAccountUser", "roles/iam.serviceAccountTokenCreator"]
	not block.Attributes.role in invalid_roles
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "IAM users are not designated with either the Service Account User or Service Account Token Creator roles at the project level.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "IAM users must not be designated with either the Service Account User or Service Account Token Creator roles at the project level.",
		"snippet": block,
	}
}
