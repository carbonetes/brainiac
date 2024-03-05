# METADATA
# title: "Verify that GitHub repositories have vulnerability alerts activated"
# description: "Activate the vulnerability alerts for the GitHub repository to receive notifications about potential security vulnerabilities in project dependencies."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository
# custom:
#   id: CB_TFGIT_003
#   severity: LOW
package lib.terraform.CB_TFGIT_003

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
	some block in input
	isvalid(block)
	block.Attributes.vulnerability_alerts == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The 'vulnerability_alerts' attribute is set to 'true'.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The 'vulnerability_alerts' attribute must be set to 'true'.",
		"snippet": block,
	}
}
