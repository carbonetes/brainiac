# METADATA
# title: "Guarantee that Security Zones have Zone Protection Profiles specified"
# description: "Verify that each Security Zone in the network configuration has a Zone Protection Profile specified. Zone Protection Profiles are essential for enforcing security policies within different network segments. Without these profiles, the network may be vulnerable to various types of attacks and security breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/PaloAltoNetworks/panos/latest/docs/resources/zone
# custom:
#   id: CB_TFPAN_014
#   severity: MEDIUM
package lib.terraform.CB_TFPAN_014

import future.keywords.in

isvalid(block) {
	supported_resources := ["panos_panorama_zone", "panos_zone", "panos_zone_entry"]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.zone_profile == ""
}

fail[block] {
	some block in input
	isvalid(block)
	not "zone_profile" in object.keys(block.Attributes)
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The attribute 'zone_profile' is not an empty string.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The attribute 'zone_profile' either does not exist or is an empty string.",
		"snippet": block,
	}
}
