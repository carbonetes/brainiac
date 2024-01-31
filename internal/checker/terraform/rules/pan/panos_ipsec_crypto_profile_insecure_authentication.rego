# METADATA
# title: "Guarantee that IPsec profiles do not employ insecure authentication algorithms"
# description: "Verify that IPsec profiles do not utilize vulnerable authentication algorithms, which could pose security risks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/PaloAltoNetworks/panos/latest/docs/resources/ipsec_crypto_profile
# custom:
#   id: CB_TFPAN_012
#   severity: MEDIUM
package lib.terraform.CB_TFPAN_012

import future.keywords.in

isvalid(block) {
	supported_resources := ["panos_ipsec_crypto_profile", "panos_panorama_ipsec_crypto_profile"]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
}

fail[block] {
	restricted_values := [
		"none",
		"md5",
		"sha1",
	]
	some block in input
	isvalid(block)
	some restricted in block.Attributes.authentications
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
		"message": "The attribute 'authentications' contains no insecure algorithms.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The attribute 'authentications' must not contain insecure algorithms.",
		"snippet": block,
	}
}
