# METADATA
# title: "Avoid Using CAP_SYS_ADMIN Linux Capability"
# description: "This policy recommends avoiding the use of the CAP_SYS_ADMIN Linux capability in container configurations. This capability grants extensive system administration privileges, posing potential security risks."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_028
#   severity: HIGH
package lib.terraform.CB_TFK8S_028

import future.keywords.in

isvalid(block) {
	supported_resources := [
		"kubernetes_deployment",
		"kubernetes_deployment_v1",
		"kubernetes_pod",
		"kubernetes_pod_v1",
	]
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

fail[resource] {
	some resource in input
	isvalid(resource)
	some spec_block in resource.Blocks
	spec_block.Type == "spec"
	some template_block in spec_block.Blocks
	template_block.Type == "template"
	some template_spec_block in template_block.Blocks
	template_spec_block.Type == "spec"
	some spec_container_block in template_spec_block.Blocks
	spec_container_block.Type == "container"
	some container_security_context_block in spec_container_block.Blocks
	container_security_context_block.Type == "security_context"
	some security_context_capabilities_block in container_security_context_block.Blocks
	security_context_capabilities_block.Type == "capabilities"
	some add in security_context_capabilities_block.Attributes.add
	add == "SYS_ADMIN"
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Containers do not use the CAP_SYS_ADMIN Linux capability, ensuring a more secure environment.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": " Some containers use the CAP_SYS_ADMIN Linux capability. Revise the configuration to exclude this capability for improved security.",
		"snippet": block,
	}
}
