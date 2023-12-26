# METADATA
# title: "Restrict Containers with Assigned Capabilities"
# description: "This policy aims to minimize the admission of containers with assigned capabilities. By restricting unnecessary capabilities, potential security risks associated with excessive container privileges are reduced."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_security_policy
# custom:
#   id: CB_TFK8S_027
#   severity: LOW
package lib.terraform.CB_TFK8S_027

import future.keywords.in

isvalid(resource) {
	supported_resources := [
		"kubernetes_pod",
		"kubernetes_pod_v1",
		"kubernetes_deployment",
		"kubernetes_deployment_v1",
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
    some drop_value in ["ALL", "all"]
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
		"message": "Containers are admitted with limited and necessary capabilities, enhancing overall security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Some containers are admitted with excessive capabilities. Consider revising the configuration to limit capabilities for improved security.",
		"snippet": block,
	}
}
