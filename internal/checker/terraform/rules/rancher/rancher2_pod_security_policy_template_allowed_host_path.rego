# METADATA
# title: "Verify Rancher2 Pod Security Policy Template Allowed Host Path"
# description: "This policy ensures that Rancher2 Pod Security Policy Template Allowed Host Path are properly configured with valid and required attributes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/pod_security_policy_template
# custom:
#   id: CB_TFRAN_166
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_166

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
	not allowed_host_path(block)
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

allowed_host_path(block) {
	some innerblock in block.Blocks
	innerblock.Type == "allowed_host_path"
	innerblock.Attributes.path_prefix != ""
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Pod Security Policy Template Allowed Host Path is properly configured.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher2 Pod Security Policy Template Allowed Host Path has invalid or missing attributes. Check and fix the configuration.",
		"snippet": block,
	}
}
