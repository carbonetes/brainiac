# METADATA
# title: "Prevent force pushes in GitLab branch protection rules"
# description: "Enforce secure practices by rejecting force pushes in GitLab branch protection rules. This setting helps protect against accidental or malicious overwrites of Git history."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/branch_protection
# custom:
#   id: CB_TFGLB_002
#   severity: LOW
package lib.terraform.CB_TFGLB_002

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"gitlab_branch_protection" in block.Labels
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
	block.Attributes.allow_force_push == false
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "No force pushes found in GitLab branch protection rules.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Force pushes must be rejected in GitLab branch protection rules.",
		"snippet": block,
	}
}
