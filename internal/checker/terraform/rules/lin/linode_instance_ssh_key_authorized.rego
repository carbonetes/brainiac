# METADATA
# title: "Verify that an SSH key is configured within the authorized_keys file"
# description: "Confirm the presence of an SSH key within the authorized_keys file to enhance security and access controls for Linode instances."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/linode/linode/latest/docs/resources/instance.html
# custom:
#   id: CB_TFLIN_001
#   severity: LOW
package lib.terraform.CB_TFLIN_001

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"linode_instance" in block.Labels
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
	count(block.Attributes.authorized_keys) == 0
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The SSH key is arranged within the authorized_keys file.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The SSH key must be arranged within the authorized_keys file.",
		"snippet": block,
	}
}
