# METADATA
# title: "Verify that GitLab's prevention of secrets feature is activated"
# description: "Verify that the prevention of secrets feature is activated for GitLab projects. This is confirmed by checking that the 'prevent_secrets' push rule is set to true within the project configuration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project
# custom:
#   id: CB_TFGLB_003
#   severity: MEDIUM
package lib.terraform.CB_TFGLB_003

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
	inner_block.Attributes.prevent_secrets == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The prevention of secrets feature of GitLab is activated.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The prevention of secrets feature of GitLab must be activated.",
		"snippet": block,
	}
}
