# METADATA
# title: "Verify that the Basic Block storage is protected through encryption"
# description: "Confirm that the security of Basic Block storage by confirming that encryption measures are in place."
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/data-sources/launch_configuration
# custom:
#   id: CB_TFNCP_007
#   severity: LOW
package lib.terraform.CB_TFNCP_007

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"ncloud_launch_configuration" in block.Labels
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
		"message": "The Basic Block storage is protected through encryption.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Basic Block storage must be protected through encryption.",
		"snippet": block,
	}
}
