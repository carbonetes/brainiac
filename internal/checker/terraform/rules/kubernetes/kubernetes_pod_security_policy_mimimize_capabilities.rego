# METADATA
# title: "Limit Container Capabilities during Admission"
# description: "This policy aims to minimize the admission of containers with assigned capabilities. By restricting unnecessary capabilities, potential security risks associated with excessive container privileges are reduced."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_security_policy
# custom:
#   id: CB_TFK8S_024
#   severity: LOW
package lib.terraform.CB_TFK8S_024

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"kubernetes_pod_security_policy" in resource.Labels
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
	some block in resource.Blocks
	block.Type == "spec"
    block.Attributes.required_drop_capabilities != ""
}

pass[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "spec"
    count(block.Attributes.required_drop_capabilities) != 0
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
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
