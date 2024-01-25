# METADATA
# title: "Confirm the Spaces bucket has restricted access settings"
# description: "Verify that the access settings for the Spaces bucket are configured to restrict unauthorized access, promoting a secure and private environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/spaces_bucket
# custom:
#   id: CB_TFDIO_003
#   severity: LOW
package lib.terraform.CB_TFDIO_003

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"digitalocean_spaces_bucket" in block.Labels
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
	block.Attributes.acl == "public-read"
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The access settings for the Spaces bucket have been restricted.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The access settings for the Spaces bucket must be restricted.",
		"snippet": block,
	}
}
