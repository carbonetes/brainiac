# METADATA
# title: "Confirm that versioning is activated for the Spaces bucket"
# description: "Confirm that the Spaces bucket is configured with activated versioning to enhance data backup and recovery capabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/spaces_bucket
# custom:
#   id: CB_TFDIO_001
#   severity: MEDIUM
package lib.terraform.CB_TFDIO_001

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

pass[block] {
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "versioning"
	inner_block.Attributes.enabled == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The versioning is active for the Spaces bucket.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The versioning must be active for the Spaces bucket.",
		"snippet": block,
	}
}
