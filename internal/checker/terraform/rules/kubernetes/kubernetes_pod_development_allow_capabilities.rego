# METADATA
# title: "Verify Absence of Added Capabilities for Containers"
# description: "This policy ensures that containers are not granted additional capabilities beyond the default set. Granting unnecessary capabilities may introduce security risks."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_002
#   severity: LOW
package lib.terraform.CB_TFK8S_002

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
    not security_context_capabilities_block.Attributes.add
}


pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Containers do not have added capabilities beyond the default set, ensuring a more secure container environment.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Containers have been granted additional capabilities, posing potential security risks. Remove unnecessary capabilities to enhance container security.",
		"snippet": block,
	}
}
