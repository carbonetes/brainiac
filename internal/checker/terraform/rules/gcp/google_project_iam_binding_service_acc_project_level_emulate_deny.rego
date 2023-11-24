# METADATA
# title: "Prevent roles from emulating or controlling Service Accounts utilized at the project level"
# description: "Verify that roles do not have the capability to emulate or control Service Accounts employed at the project level, enhancing security compliance."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_binding
# custom:
#   id: CB_TFGCP_026
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_026

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
	invalid_roles := [
		"roles/owner",
		"roles/editor",
		"roles/iam.securityAdmin",
		"roles/iam.serviceAccountAdmin",
		"roles/iam.serviceAccountKeyAdmin",
		"roles/iam.serviceAccountUser",
		"roles/iam.serviceAccountTokenCreator",
		"roles/iam.workloadIdentityUser",
		"roles/dataproc.editor",
		"roles/dataproc.admin",
		"roles/dataflow.developer",
		"roles/resourcemanager.folderAdmin",
		"roles/resourcemanager.folderIamAdmin",
		"roles/resourcemanager.projectIamAdmin",
		"roles/resourcemanager.organizationAdmin",
		"roles/cloudasset.viewer",
		"roles/cloudasset.owner",
		"roles/serverless.serviceAgent",
		"roles/dataproc.serviceAgent",
	]
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
		"message": "Roles do not have the capability to emulate or control Service Accounts employed at the project level.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Roles must not have the capability to emulate or control Service Accounts employed at the project level.",
		"snippet": block,
	}
}
