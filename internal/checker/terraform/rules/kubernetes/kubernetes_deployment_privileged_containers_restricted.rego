# METADATA
# title: "Disallow the inclusion of containers with elevated privileges"
# description: "Prevent the acceptance of containers with elevated privileges to enhance Kubernetes security and minimize potential risks associated with unnecessary access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_025
#   severity: HIGH
package lib.terraform.CB_TFK8S_025

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
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "spec"
	some container_block in inner_block.Blocks
	container_block.Type == "container"
	some security_context_block in container_block.Blocks
	security_context_block.Type == "security_context"
	security_context_block.Attributes.privileged == true
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Inclusion of containers with elevated privileges has been restricted.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Inclusion of containers with elevated privileges must be restricted.",
		"snippet": block,
	}
}
