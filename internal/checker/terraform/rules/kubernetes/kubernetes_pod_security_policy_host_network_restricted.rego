# METADATA
# title: "Disallow containers attempting to distribute the host network namespace"
# description: "Prevent containers from attempting to distribute the host network namespace."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_security_policy
# custom:
#   id: CB_TFK8S_015
#   severity: MEDIUM
package lib.terraform.CB_TFK8S_015

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
	inner_block.Attributes.host_network == true
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Containers that aim to distribute the host network namespace are not allowed.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Containers that aim to distribute the host network namespace must not be allowed.",
		"snippet": block,
	}
}
