# METADATA
# title: "Prevent the use of roles that grant the ability to assume and manage all service accounts within a folder-level context"
# description: "Implement a restriction to disallow the utilization of roles that provide the capability to impersonate and oversee all service accounts at the folder level, enhancing security in this context."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_folder_iam#google_folder_iam_binding
# custom:
#   id: CB_TFGCP_006
#   severity: CRITICAL
package lib.terraform.CB_TFGCP_006

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
		"message": "Roles do not provide the capability to impersonate and oversee all service accounts at the folder level.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Roles must not provide the capability to impersonate and oversee all service accounts at the folder level",
		"snippet": block,
	}
}
