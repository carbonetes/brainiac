# METADATA
# title: "Verify that the KMS policy does not permit public access"
# description: "Confirm that the Key Management Service (KMS) policy is configured to restrict access and does not allow public exposure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_kms_crypto_key_iam#google_kms_crypto_key_iam_policy
# custom:
#   id: CB_TFGCP_066
#   severity: HIGH
package lib.terraform.CB_TFGCP_066

import future.keywords.in

isvalid(block) {
	supported_resources := ["google_kms_crypto_key_iam_policy", "google_kms_crypto_key_iam_binding", "google_kms_crypto_key_iam_member"]
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

fail[block] {
	some block in input
	isvalid(block)
	invalid_members := [
		"allUsers",
		"allAuthenticatedUsers",
	]
	some members in block.Attributes.members
	members in invalid_members
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Key Management Service (KMS) policy is configured to restrict public access.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Key Management Service (KMS) policy must be configured to restrict public access.",
		"snippet": block,
	}
}
