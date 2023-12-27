# METADATA
# title: "Avoid allowing containers that intend to distribute the host process ID namespace"
# description: "Verify that containers are not permitted to share the host process ID namespace, preventing potential security risks and assuring isolation between processes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod
# custom:
#   id: CB_TFK8S_035
#   severity: MEDIUM
package lib.terraform.CB_TFK8S_035

import future.keywords.in

isvalid(block) {
	supported_resources := ["kubernetes_pod", "kubernetes_pod_v1"]
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
	block.Type == "resource"
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "spec"
	inner_block.Attributes.host_pid == true
}

pass[block] {
	some block in input
	block.Type == "resource"
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Containers that intend to distribute the host process ID namespace are not found.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Containers that intend to distribute the host process ID namespace is not allowed.",
		"snippet": block,
	}
}
