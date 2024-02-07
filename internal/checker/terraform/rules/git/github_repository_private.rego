# METADATA
# title: "Verify that the GitHub repository has been configured as a private repository"
# description: "Verify GitHub repository privacy settings for enhanced security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository
# custom:
#   id: CB_TFGIT_001
#   severity: MEDIUM
package lib.terraform.CB_TFGIT_001

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"github_repository" in block.Labels
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
	expected_values := ["internal", "private"]
	some block in input
	isvalid(block)
	block.Attributes.visibility in expected_values
}

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.private == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The GitHub repository has been set as a private repository.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The GitHub repository must be set as a private repository.",
		"snippet": block,
	}
}
