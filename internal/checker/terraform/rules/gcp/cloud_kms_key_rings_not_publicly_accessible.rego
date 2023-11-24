# METADATA
# title: "Verify that Cloud KMS Key Rings are not anonymously or publicly accessible"
# description: "This ensures that Key Rings in Cloud Key Management Service (KMS) are properly secured, reducing the risk of unauthorized access and enhancing overall key management security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring
# custom:
#   id: CB_TFGCP_107
#   severity: HIGH
package lib.terraform.CB_TFGCP_107

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_kms_key_ring" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_key_ring[label] {
	some block in input
	block.Type == "resource"
	"google_kms_key_ring" in block.Labels
	label := concat(".", block.Labels)
}

key_ring_connected(block){
	some label in label_for_key_ring
	contains(block.Attributes.key_ring_id, label)
}

invalid_members := [
	"allUsers",
	"allAuthenticatedUsers",
]

fail[block] {
	some block in input
	block.Type == "resource"
	"google_kms_key_ring_iam_member" in block.Labels
	key_ring_connected(block)
	block.Attributes.member in invalid_members
}

fail[block] {
	some block in input
	block.Type == "resource"
	"google_kms_key_ring_iam_binding" in block.Labels
	key_ring_connected(block)
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
		"message": "Cloud KMS Key Rings are not anonymously or publicly accessible.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Cloud KMS Key Rings should not be anonymously or publicly accessibles.",
		"snippet": block,
	}
}
