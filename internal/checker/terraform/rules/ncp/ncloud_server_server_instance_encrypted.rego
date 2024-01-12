# METADATA
# title: "Verify that the server instance is protected through encryption"
# description: "Confirm that the server instance is safeguarded by encryption, enhancing the security and protection of sensitive data."
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/server
# custom:
#   id: CB_TFNCP_006
#   severity: MEDIUM
package lib.terraform.CB_TFNCP_006

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"ncloud_server" in block.Labels
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
	block.Attributes.is_encrypted_base_block_storage_volume == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The server instance is protected through encryption.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The server instance must be protected through encryption.",
		"snippet": block,
	}
}
