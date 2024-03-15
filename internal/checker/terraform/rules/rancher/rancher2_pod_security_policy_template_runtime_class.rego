# METADATA
# title: "Verify Rancher2 Pod Security Policy Template Runtime Class"
# description: "This policy ensures that Rancher2 Pod Security Policy Template Runtime Class are properly configured with valid and required attributes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/pod_security_policy_template
# custom:
#   id: CB_TFRAN_171
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_171

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_pod_security_policy_template" in block.Labels
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
	not runtime_class(block)
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

runtime_class(block) {
	some innerblock in block.Blocks
	innerblock.Type == "runtime_class"
	innerblock.Attributes.allowed_runtime_class_names != []
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Pod Security Policy Template Runtime Class is properly configured.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher2 Pod Security Policy Template Runtime Class has invalid or missing attributes. Check and fix the configuration.",
		"snippet": block,
	}
}
