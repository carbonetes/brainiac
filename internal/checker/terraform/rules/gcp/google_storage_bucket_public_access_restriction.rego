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

isvalid(resource) {
    supported_resources = ["google_storage_bucket_iam_binding", "google_storage_bucket_iam_member"]
    resource.Type == "resource"
    some label in resource.Labels
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

fail[resource] {
    some resource in input
    isvalid(resource)
    "allUsers" in resource.Attributes.members
}

fail[resource] {
    some resource in input
    isvalid(resource)
    "allAuthenticatedUsers" in resource.Attributes.members
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