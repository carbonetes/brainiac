# METADATA
# title: "Verify that the GitHub Actions secrets are securely encrypted"
# description: "Verify that the secrets used in GitHub Actions are adequately encrypted to safeguard sensitive information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_secret
# custom:
#   id: CB_TFGIT_004
#   severity: HIGH
package lib.terraform.CB_TFGIT_004

import future.keywords.in

isvalid(block) {
	supported_resources := [
		"github_actions_environment_secret",
		"github_actions_organization_secret",
		"github_actions_secret",
	]
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

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.plaintext_value != ""
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The plaintext_value is empty.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The plaintext_value must not contain any value.",
		"snippet": block,
	}
}
