# METADATA
# title: "Verify Minimization of Containers with NET_RAW Capability"
# description: "This policy aims to minimize the admission of containers with the NET_RAW capability. The NET_RAW capability allows a container to create raw network sockets, which can pose security risks. Minimizing this capability helps enhance the security posture of the containerized environment."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_012
#   severity: MEDIUM
package lib.terraform.CB_TFK8S_012

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
    some drop_value in ["ALL", "NET_RAW"]
    some drop in security_context_capabilities_block.Attributes.drop
    drop == drop_value
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Container admission with the NET_RAW capability is minimized, promoting a more secure container environment.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Container admission with the NET_RAW capability is detected, posing potential security risks. Consider limiting the use of NET_RAW capability to enhance container security.",
		"snippet": block,
	}
}
