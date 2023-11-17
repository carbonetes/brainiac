# METADATA
# title: "Verify KMS keys are protected from deletion"
# description: "This ensures that Key Management Service (KMS) keys are safeguarded against accidental or unauthorized deletion, maintaining the integrity of cryptographic key management."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key
# custom:
#   id: CB_TFGCP_084
#   severity: LOW
package lib.terraform.CB_TFGCP_084
import future.keywords.in

isvalid(block){
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
	some inner_block in block.Blocks
	inner_block.Type == "lifecycle"
	inner_block.Attributes.prevent_destroy == true
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "KMS keys are protected from deletion.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "KMS keys should be protected from deletion.",
                "snippet": block }
}