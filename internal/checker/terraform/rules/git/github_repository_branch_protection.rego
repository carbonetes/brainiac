# METADATA
# title: "Verify that every repository is linked with branch protection"
# description: "Confirm that each repository establishes a connection with branch protection, enhancing overall security measures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository
# custom:
#   id: CB_TFGIT_007
#   severity: LOW
package lib.terraform.CB_TFGIT_007

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"github_branch_protection" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_git_repo[label] {
	some block in input
	block.Type == "resource"
	"github_repository" in block.Labels
	label := concat(".", block.Labels)
}

git_repo_attached_protection {
	some block in input
	block.Type == "resource"
	"github_branch_protection" in block.Labels
	some label in label_for_git_repo
	contains(block.Attributes.repository, label)
}

git_repo_attached_protection_v3 {
	some block in input
	block.Type == "resource"
	"github_branch_protection_v3" in block.Labels
	some label in label_for_git_repo
	contains(block.Attributes.repository, label)
}

fail[block] {
	some block in input
	isvalid(block)
	not git_repo_attached_protection
	not git_repo_attached_protection_v3
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Every repository is connected with branch protection.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Every repository must be connected with branch protection.",
		"snippet": block,
	}
}
