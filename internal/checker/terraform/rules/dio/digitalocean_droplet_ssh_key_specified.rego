# METADATA
# title: "Confirm that the droplet is configured with an SSH key"
# description: "Verify that the droplet is configured with an SSH key to enhance security and enable secure access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet
# custom:
#   id: CB_TFDIO_002
#   severity: MEDIUM
package lib.terraform.CB_TFDIO_002

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"digitalocean_droplet" in block.Labels
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
	count(block.Attributes.ssh_keys) != 0
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The droplet is set with an SSH key.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The droplet must be set with an SSH key.",
		"snippet": block,
	}
}
