# METADATA
# title: "Verify GitHub branch protection rules mandate the use of signed commits"
# description: "Guarantee that GitHub branch protection rules enforce the necessity of signed commits, contributing to a more secure and trustworthy version control workflow."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection
# custom:
#   id: CB_TFGIT_006
#   severity: LOW
package lib.terraform.CB_TFGIT_006

import future.keywords.in

isvalid(block) {
	supported_resources := ["github_branch_protection", "github_branch_protection_v3"]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
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
	block.Attributes.require_signed_commits == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The attribute 'require_signed_commits' is set to 'true'.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The attribute 'require_signed_commits' must be set to 'true'.",
		"snippet": block,
	}
}
