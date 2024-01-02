# METADATA
# title: "Disallow containers that aim to distribute the host process ID namespace"
# description: "Prevent the admission of containers attempting to distribute the host process ID namespace."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_security_policy
# custom:
#   id: CB_TFK8S_001
#   severity: MEDIUM
package lib.terraform.CB_TFK8S_001

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

fail[block] {
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "spec"
	inner_block.Attributes.host_pid == true
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "host_pid is set to false, admission of containers that distributes this is disabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "host_pid is set to true, admission of containers that distributes this is enabled.",
		"snippet": block,
	}
}
