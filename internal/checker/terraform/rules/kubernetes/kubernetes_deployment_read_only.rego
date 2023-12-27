# METADATA
# title: "Employ a read-only filesystem whenever feasible for containers"
# description: "Implement a read-only filesystem for containers when it is practical to enhance security measures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_040
#   severity: LOW
package lib.terraform.CB_TFK8S_040

import future.keywords.in

isvalid(block) {
	supported_resources := ["kubernetes_deployment", "kubernetes_deployment_v1", "kubernetes_pod", "kubernetes_pod_v1"]
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
	some containers_block in inner_block.Blocks
	containers_block.Type == "containers"
	some security_block in containers_block.Blocks
	security_block.Type == "securityContext"
	security_block.Attributes.readOnlyRootFilesystem == false
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The read-only filesystem is being utilized.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The read-only filesystem must be utilized.",
		"snippet": block,
	}
}
