# METADATA
# title: "Avoid allowing containers that intend to distribute the host process ID namespace"
# description: "Verify that containers are not permitted to share the host process ID namespace, preventing potential security risks and assuring isolation between processes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_034
#   severity: MEDIUM
package lib.terraform.CB_TFK8S_034

import future.keywords.in

isvalid(block) {
	supported_resources := ["kubernetes_deployment", "kubernetes_deployment_v1"]
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
	some template_block in inner_block.Blocks
	template_block.Type == "template"
	some spec_block in template_block.Blocks
	spec_block.Type == "spec"
	spec_block.Attributes.host_pid == true
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
