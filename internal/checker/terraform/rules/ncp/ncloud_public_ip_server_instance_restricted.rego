# METADATA
# title: "Verify that the server instance does not possess a public IP address"
# description: "Confirm  that server instances do not possess a public IP address assigned, which enhances security by restricting external accessibility. This check helps prevent potential vulnerabilities associated with exposing server instances to the public network."
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/public_ip
# custom:
#   id: CB_TFNCP_022
#   severity: MEDIUM
package lib.terraform.CB_TFNCP_022

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"ncloud_public_ip" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[block] {
	some block in input
	isvalid(block)
	count(block.Attributes.server_instance_no) >= 1
}

fail[block] {
	some block in input
	isvalid(block)
	"server_instance_no" in object.keys(block.Attributes)
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The server instance does not possess a public IP address.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The server instance must not possess a public IP address.",
		"snippet": block,
	}
}
