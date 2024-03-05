# METADATA
# title: "Verify Rancher Role Template Supported Context"
# description: "Policy to verify supported contexts for Rancher2 Role Template."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/role_template
# custom:
#   id: CB_TFRAN_181
#   severity: LOW
package lib.terraform.CB_TFRAN_181

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_role_template" in block.Labels
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
	not supported_context(block)
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

supported_context(block) {
	context := [
		"cluster",
		"project",
	]
	block.Attributes.context in context
}

passed[result] {
	some block in pass
	result := {
		"message": "Supported contexts for Rancher2 Role Template have been successfully verified.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Ensure that the supported contexts for Rancher2 Role Template are correctly configured.",
		"snippet": block,
	}
}
