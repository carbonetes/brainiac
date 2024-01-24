# METADATA
# title: "GitHub pull requests must have a minimum of two approvals"
# description: "Verify that GitHub pull requests mandate a minimum of two approvals to enhance code review and collaboration in the development process."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection
# custom:
#   id: CB_TFGIT_005
#   severity: MEDIUM
package lib.terraform.CB_TFGIT_005

import future.keywords.in

isvalid(block) {
	supported_resources := ["github_branch_protection", "github_branch_protection_v3", "kubernetes_pod", "kubernetes_pod_v1"]
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
	some inner_block in block.Blocks
	inner_block.Type == "required_pull_request_reviews"
	to_number(inner_block.Attributes.required_approving_review_count) >= 2
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The attribute 'required_approving_review_count' is greater or equal to 2.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The attribute 'required_approving_review_count' is less than 2.",
		"snippet": block,
	}
}
