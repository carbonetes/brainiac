# METADATA
# title: "Guarantee that IPsec profiles do not indicate the utilization of vulnerable protocols"
# description: "Verify that IPsec profiles do not specify the utilization of insecure protocols, aiming to maintain network security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/PaloAltoNetworks/panos/latest/docs/resources/ipsec_crypto_profile
# custom:
#   id: CB_TFPAN_013
#   severity: MEDIUM
package lib.terraform.CB_TFPAN_013

import future.keywords.in

isvalid(block) {
	supported_resources := ["panos_ipsec_crypto_profile", "panos_panorama_ipsec_crypto_profile"]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.protocol == "ah"
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The attribute 'protocol' contains no insecure protocols.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The attribute 'protocol' must not contain insecure protocols.",
		"snippet": block,
	}
}
