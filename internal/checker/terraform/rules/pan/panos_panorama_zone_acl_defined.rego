# METADATA
# title: "Guarantee that a Zone has an Include ACL specified when User-ID is activated"
# description: "Verify that an Include Access Control List (ACL) is configured for a zone when User-ID functionality is enabled. Failure to define an Include ACL when User-ID is activated can lead to security vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/PaloAltoNetworks/panos/latest/docs/resources/zone
# custom:
#   id: CB_TFPAN_015
#   severity: MEDIUM
package lib.terraform.CB_TFPAN_015

import future.keywords.in

isvalid(block) {
	supported_resources := ["panos_panorama_zone", "panos_zone"]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
}

fail[block] {
	restricted_value := [""]
	some block in input
	isvalid(block)
	block.Attributes.enable_user_id == true
	some restricted in block.Attributes.include_acls
	restricted in restricted_value
	count(block.Attributes.include_acls) == 1
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The attribute 'include_acls' is not an empty string when User-ID is activated.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The attribute 'include_acls' is an empty string when User-ID is activated.",
		"snippet": block,
	}
}
