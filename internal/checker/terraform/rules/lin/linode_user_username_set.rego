# METADATA
# title: "Verify that username is configured"
# description: "Confirm the username is configured on the Linode user account."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/linode/linode/latest/docs/resources/user
# custom:
#   id: CB_TFLIN_003
#   severity: LOW
package lib.terraform.CB_TFLIN_003

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"linode_user" in block.Labels
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
	block.Attributes.username != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The username is present.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The username is required.",
		"snippet": block,
	}
}
