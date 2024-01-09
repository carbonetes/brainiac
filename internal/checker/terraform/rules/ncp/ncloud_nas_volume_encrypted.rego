# METADATA
# title: "Verify that the Network Attached Storage (NAS) is protected with robust encryption measures"
# description: "Confirm the implementation of strong encryption measures to safeguard the Network Attached Storage (NAS) and assure its secure operation."
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/data-sources/nas_volume
# custom:
#   id: CB_TFNCP_014
#   severity: MEDIUM
package lib.terraform.CB_TFNCP_014

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"ncloud_nas_volume" in block.Labels
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
	block.Attributes.is_encrypted_volume == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Network Attached Storage (NAS) is protected with strong encryption measures.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Network Attached Storage (NAS) must be protected with strong encryption measures.",
		"snippet": block,
	}
}
