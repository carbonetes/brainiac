# METADATA
# title: "Confirm that the image tag is set to a specific value and not left as latest or left blank"
# description: "Verify that the image tag is explicitly defined and not left as latest or left empty. This practice enhances traceability and facilitates proper rollback procedures in production deployments."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_022
#   severity: LOW
package lib.terraform.CB_TFK8S_022

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
	not contains(container_block.Attributes.image, ":latest")
}

pass[block] {
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "spec"
	some container_block in inner_block.Blocks
	container_block.Type == "container"
	not contains(container_block.Attributes.image, ":")
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "image tag is set to a specific value and not left as latest or left blank.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "image tag must not be set as latest or left blank.",
		"snippet": block,
	}
}
