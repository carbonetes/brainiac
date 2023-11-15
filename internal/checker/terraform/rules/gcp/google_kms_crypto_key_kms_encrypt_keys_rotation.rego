# METADATA
# title: "Verify that the KMS encryption keys undergo rotation within a 90-day timeframe"
# description: "Confirm that encryption keys in KMS (Key Management Service) undergo regular rotation, ensuring a secure practice within a specified 90-day timeframe."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key
# custom:
#   id: CB_TFGCP_056
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_056

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_kms_crypto_key" in block.Labels
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
	block.Attributes.rotation_period == "7776000s"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The KMS encryption keys undergo rotation within a 90-day timeframe.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The KMS encryption keys must undergo rotation within a 90-day timeframe.",
		"snippet": block,
	}
}
