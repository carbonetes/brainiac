# METADATA
# title: "Guarantee that Service Accounts do not possess Administrator-level permissions"
# description: "Confirm that Service Accounts are not granted Administrator-level permissions, promoting a more secure access control configuration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_binding
# custom:
#   id: CB_TFGCP_005
#   severity: HIGH
package lib.terraform.CB_TFGCP_005

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_project_iam_member" in block.Labels
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
	block.Attributes.member == "user:test@example-project.iam.gserviceaccount.com"
	block.Attributes.role == "roles/owner"
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Service Accounts are not granted Administrator-level permissions.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Service Accounts must not be granted Administrator-level permissions.",
		"snippet": block,
	}
}
