# METADATA
# title: "Prevent containers from having supplementary capabilities"
# description: "that containers do not possess extra capabilities beyond the default set, enhancing security by preventing the inclusion of supplementary capabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_security_policy
# custom:
#   id: CB_TFK8S_041
#   severity: LOW
package lib.terraform.CB_TFK8S_041

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"kubernetes_pod_security_policy" in block.Labels
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
	block.Type == "resource"
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "spec"
	count(inner_block.Attributes.allowed_capabilities) == 0
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The containers do not have extra capabilities.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The containers must not have extra capabilities.",
		"snippet": block,
	}
}
