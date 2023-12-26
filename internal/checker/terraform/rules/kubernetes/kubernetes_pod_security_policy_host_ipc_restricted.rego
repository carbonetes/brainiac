# METADATA
# title: "Prevent the inclusion of containers seeking to share the host IPC namespace"
# description: "Confirm that containers intending to share the host IPC namespace are not allowed for admission."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_security_policy
# custom:
#   id: CB_TFK8S_004
#   severity: MEDIUM
package lib.terraform.CB_TFK8S_004

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
	inner_block.Attributes.host_ipc == true
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Containers that aim to share the host IPC namespace are not allowed.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Containers that aim to share the host IPC namespace must not be allowed.",
		"snippet": block,
	}
}
