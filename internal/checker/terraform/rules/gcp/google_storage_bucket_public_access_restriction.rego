# METADATA
# title: "Verify Cloud Storage Bucket Access Restrictions"
# description: "This policy ensures that Cloud Storage buckets are not configured for anonymous or public access, enhancing security by restricting unauthorized entry."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam
# custom:
#   id: CB_TFGCP_031
#   severity: HIGH
package lib.terraform.CB_TFGCP_031

import future.keywords.in

isvalid(block) {
	supported_resources := ["google_storage_bucket_iam_binding", "google_storage_bucket_iam_member"]
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

fail[resource] {
    some resource in input
    resource.Type == "resource"
    "google_storage_bucket_iam_member" in resource.Labels
    resource.Attributes.member in invalid_members
}

fail[resource] {
    some resource in input
    resource.Type == "resource"
    "google_storage_bucket_iam_binding" in resource.Labels
    some member in resource.Attributes.members
    member in invalid_members
}

pass[resource] {
    some resource in input
    isvalid(resource)
    not fail[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "Cloud Storage bucket is not anonymously or publicly accessible, ensuring secure access controls.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "The Cloud Storage bucket allows anonymous or public access, posing a security risk. Adjust access controls to restrict unauthorized entry.",
        "snippet": block,
    }
}
