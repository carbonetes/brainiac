# METADATA
# title: "Guarantee that the enforcement of public access prevention is in place for the Cloud Storage bucket"
# description: "Verify that Cloud Storage bucket security is maintained by assuring the enforcement of public access prevention measures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
# custom:
#   id: CB_TFGCP_089
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_089

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_storage_bucket" in block.Labels
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
	block.Attributes.public_access_prevention == "enforced"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The enforcement of public access prevention is in place for the Cloud Storage bucket.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "There must be an enforcement of public access prevention in place for the Cloud Storage bucket.",
		"snippet": block,
	}
}
