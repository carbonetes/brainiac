# METADATA
# title: "Verify that IPsec profiles do not indicate the utilization of vulnerable encryption algorithms"
# description: "Verify that IPsec profiles do not utilize encryption algorithms known to be insecure. IPsec, or Internet Protocol Security, is critical for securing network communications, and the use of vulnerable encryption algorithms can compromise the confidentiality and integrity of data transmissions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/PaloAltoNetworks/panos/latest/docs/resources/ipsec_crypto_profile
# custom:
#   id: CB_TFPAN_011
#   severity: MEDIUM
package lib.terraform.CB_TFPAN_011

import future.keywords.in

isvalid(block) {
	supported_resources := ["panos_ipsec_crypto_profile", "panos_panorama_ipsec_crypto_profile"]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
}

fail[block] {
	restricted_values := [
		"des",
		"3des",
		"aes-128-cbc",
		"aes-192-cbc",
		"aes-256-cbc",
		"null",
	]
	some block in input
	isvalid(block)
	some restricted in block.Attributes.encryptions
	restricted in restricted_values
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The attribute 'encryptions' contains no insecure algorithms.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The attribute 'encryptions' must not contain insecure algorithms.",
		"snippet": block,
	}
}
