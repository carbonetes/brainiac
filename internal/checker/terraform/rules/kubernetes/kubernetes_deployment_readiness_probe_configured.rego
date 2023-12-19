# METADATA
# title: "Confirm that the readiness Probe is properly set up"
# description: "Confirm that the readiness probe is correctly configured and functional."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_011
#   severity: LOW
package lib.terraform.CB_TFK8S_011

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

pass[block] {
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "spec"
	some container_block in inner_block.Blocks
	container_block.Type == "container"
	some liveness_probe_block in container_block.Blocks
	liveness_probe_block.Type == "readiness_probe"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Readiness probe has been set up properly.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Readiness probe must be properly set up.",
		"snippet": block,
	}
}
