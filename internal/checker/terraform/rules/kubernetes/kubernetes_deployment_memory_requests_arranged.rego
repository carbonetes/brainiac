# METADATA
# title: "Confirm that memory requests are configured appropriately"
# description: "Verify that the memory requests have been configured appropriately to assure optimal system performance and resource allocation."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_021
#   severity: LOW
package lib.terraform.CB_TFK8S_021

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
	some resources_block in container_block.Blocks
	resources_block.Type == "resources"
	"memory" in object.keys(resources_block.Attributes.requests)
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Memory requests are configured.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Memory requests must be configured.",
		"snippet": block,
	}
}
