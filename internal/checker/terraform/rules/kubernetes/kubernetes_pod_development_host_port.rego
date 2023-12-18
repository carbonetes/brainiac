# METADATA
# title: "Verify Absence of Unnecessary hostPort Specification"
# description: "This policy ensures that the hostPort is not specified for containers unless absolutely necessary. Specifying unnecessary hostPorts may introduce security and port allocation conflicts."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_008
#   severity: LOW
package lib.terraform.CB_TFK8S_008

import future.keywords.in

isvalid(resource) {
	supported_resources := [
		"kubernetes_deployment",
		"kubernetes_deployment_v1",
		"kubernetes_pod",
		"kubernetes_pod_v1",
	]
	resource.Type == "resource"
	some label in resource.Labels
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

pass[resource] {
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
	some container_port_block in spec_container_block.Blocks
	container_port_block.Type == "port"
	container_port_block.Attributes.host_port != null
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Containers do not specify unnecessary hostPorts, promoting a more secure and conflict-free container environment.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Containers have specified unnecessary hostPorts, which may lead to security vulnerabilities and port conflicts. Remove unnecessary hostPort specifications for enhanced container security.",
		"snippet": block,
	}
}
