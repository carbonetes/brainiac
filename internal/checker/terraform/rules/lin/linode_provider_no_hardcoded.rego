# METADATA
# title: "Verify that Linode tokens are not hardcoded within the provider configuration"
# description: "Verify if Linode tokens are hardcoded within the provider configuration, which may expose sensitive informations."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/linode/linode/latest/docs/resources/token
# custom:
#   id: CB_TFLIN_006
#   severity: MEDIUM
package lib.terraform.CB_TFLIN_006

import future.keywords.in

isvalid(block) {
	block.Type == "provider"
	"linode" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_linode_token[label] {
	some block in input
	block.Type == "variable"
	"linode_token" in block.Labels
	label := concat(".", block.Labels)
}

linode_token_connected {
	some block in input
	block.Type == "provider"
	"linode" in block.Labels
	some label in label_for_linode_token
	contains(block.Attributes.token, label)
}

pass[block] {
	some block in input
	isvalid(block)
	linode_token_connected
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "No hardcoded linode token found within the provider configuration.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Linode tokens must not be hardcoded within the provider configuration.",
		"snippet": block,
	}
}
