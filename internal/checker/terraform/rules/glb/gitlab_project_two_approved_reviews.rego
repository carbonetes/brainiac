# METADATA
# title: "Verify that a GitLab merge request mandates a minimum of two approving reviews for the merge process"
# description: "Enforce a minimum of two approvals before merging GitLab merge requests in the 'example' project."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project
# custom:
#   id: CB_TFGLB_001
#   severity: LOW
package lib.terraform.CB_TFGLB_001

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"gitlab_project" in block.Labels
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
	to_number(block.Attributes.approvals_before_merge) >= 2
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Two approving reviews for the merge process are present, merge request accepted.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Two approving reviews for the merge process must be present, merge request denied.",
		"snippet": block,
	}
}
