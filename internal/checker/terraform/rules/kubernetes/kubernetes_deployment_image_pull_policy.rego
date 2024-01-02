# METADATA
# title: "Confirm that the Image Pull Policy is set to 'Always' for containers"
# description: "Set the Image Pull Policy to 'Always' for containers, enhancing security by assuring the retrieval of the correct and up-to-date images."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_042
#   severity: LOW
package lib.terraform.CB_TFK8S_042

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
	block.Type == "resource"
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "spec"
	some container_block in inner_block.Blocks
	container_block.Type == "container"
	container_block.Attributes.image_pull_policy == "Always"
}

pass[block] {
	some block in input
	block.Type == "resource"
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "spec"
	some container_block in inner_block.Blocks
	container_block.Type == "container"
	endswith(container_block.Attributes.image, "latest")
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Image Pull Policy is set to 'Always' for containerss.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Image Pull Policy must be set to 'Always' for containers.",
		"snippet": block,
	}
}
