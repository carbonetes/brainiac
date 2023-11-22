# METADATA
# title: "Verify that there are only GCP-managed service account keys for each service account"
# description: "This ensures that service accounts within Google Cloud Platform (GCP) are securely managed, limiting access to only GCP-managed keys. This minimizes the risk associated with unauthorized access through unmanaged keys."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_key
# custom:
#   id: CB_TFGCP_103
#   severity: LOW
package lib.terraform.CB_TFGCP_103

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_service_account_key" in block.Labels
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
    "public_key_data" in object.keys(block.Attributes)
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "There are only GCP-managed service account keys for each service account.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "There should only GCP-managed service account keys for each service account.",
		"snippet": block,
	}
}
