# METADATA
# title: "Verify Uniform Bucket-Level Access for Cloud Storage Buckets"
# description: "This policy ensures that Cloud Storage buckets have uniform bucket-level access enabled, promoting consistent and secure access controls across the buckets."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
# custom:
#   id: CB_TFGCP_038
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_038

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"google_storage_bucket" in resource.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.uniform_bucket_level_access == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Cloud Storage buckets have uniform bucket-level access enabled, ensuring consistent and secure access controls.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Uniform bucket-level access is not enabled for the Cloud Storage buckets, leading to inconsistent access controls. Enable uniform bucket-level access for enhanced security.",
		"snippet": block,
	}
}
