# METADATA
# title: "Verify that email is configured"
# description: "Confirm the presence of a configured email address for enhanced security measures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/linode/linode/latest/docs/resources/user
# custom:
#   id: CB_TFLIN_002
#   severity: LOW
package lib.terraform.CB_TFLIN_002

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
	block.Attributes.email != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The email is present.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The email is required.",
		"snippet": block,
	}
}
