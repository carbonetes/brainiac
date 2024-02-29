# METADATA
# title: "Verify Rancher2 Pod Security Policy Template Host Port"
# description: "This policy ensures that Rancher2 Pod Security Policy Template Host Port are properly configured with valid and required attributes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/pod_security_policy_template
# custom:
#   id: CB_TFRAN_168
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_168

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
	not host_port(block)
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

host_port(block) {
	some innerblock in block.Blocks
	innerblock.Type == "host_port"
	innerblock.Attributes.max != ""
	innerblock.Attributes.min != ""
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Pod Security Policy Template Host Port is properly configured.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher2 Pod Security Policy Template Host Port has invalid or missing attributes. Check and fix the configuration.",
		"snippet": block,
	}
}
