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

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/owner"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/editor"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/iam.securityAdmin"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/iam.serviceAccountAdmin"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/iam.serviceAccountKeyAdmin"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/iam.serviceAccountUser"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/iam.serviceAccountTokenCreator"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/iam.workloadIdentityUser"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/dataproc.editor"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/dataproc.admin"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/dataflow.developer"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/resourcemanager.folderAdmin"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/resourcemanager.folderIamAdmin"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/resourcemanager.projectIamAdmin"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/resourcemanager.organizationAdmin"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/cloudasset.viewer"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/cloudasset.owner"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/serverless.serviceAgent"
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.role == "roles/dataproc.serviceAgent"
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
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
