# METADATA
# title: "Verify that GitLab commits are digitally signed"
# description: "Verify that GitLab rejects commits that are not digitally signed. This is configured by setting the reject_unsigned_commits attribute to true in the push rules of the GitLab project."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project
# custom:
#   id: CB_TFGLB_004
#   severity: LOW
package lib.terraform.CB_TFGLB_004

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
	some inner_block in block.Blocks
	inner_block.Type == "push_rules"
	inner_block.Attributes.reject_unsigned_commits == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "GitLab commits are signed, reject_unsigned_commits is set to true.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "GitLab commits are not signed, reject_unsigned_commits must be set to true.",
		"snippet": block,
	}
}
