# METADATA
# title: "Verify that Container Registry repositories are not anonymously or publicly accessible"
# description: "This ensures that access to Container Registry repositories is restricted, enhancing security by preventing unauthorized or public access to container images."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam
# custom:
#   id: CB_TFGCP_112
#   severity: HIGH
package lib.terraform.CB_TFGCP_112

import future.keywords.in

isvalid(block) {
	supported_resources := [ "google_storage_bucket_iam_member",
							"google_storage_bucket_iam_binding"]
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

invalid_members := [
	"allUsers",
	"allAuthenticatedUsers",
]

fail[block] {
	some block in input
	block.Type == "resource"
	"google_storage_bucket_iam_member" in block.Labels
	block.Attributes.member in invalid_members
}

fail[block] {
	some block in input
	block.Type == "resource"
	"google_storage_bucket_iam_binding" in block.Labels
	some member in block.Attributes.members
	member in invalid_members
}


pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Container Registry repositories are not anonymously or publicly accessible.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Container Registry repositories are not anonymously or publicly accessible.",
		"snippet": block,
	}
}
