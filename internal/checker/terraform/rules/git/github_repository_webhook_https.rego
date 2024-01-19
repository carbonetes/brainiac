# METADATA
# title: "Verify that GitHub repository webhooks are configured to use the HTTPS protocol"
# description: "Confirm that GitHub repository webhooks are utilizing HTTPS protocol. This involves setting up webhooks with secure communication over HTTPS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_webhook
# custom:
#   id: CB_TFGIT_002
#   severity: LOW
package lib.terraform.CB_TFGIT_002

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"github_repository_webhook" in block.Labels
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
	inner_block.Type == "configuration"
	inner_block.Attributes.insecure_ssl == false
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The GitHub repository webhooks are utilizing to use the HTTPS protocol.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The GitHub repository webhooks must utilize to use the HTTPS protocol.",
		"snippet": block,
	}
}
