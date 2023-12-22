# METADATA
# title: "Containers must avoid operating with the allowPrivilegeEscalation setting"
# description: "Prevent containers from executing with the allowPrivilegeEscalation setting, enhancing overall security by minimizing potential vulnerabilities associated with elevated privileges."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_043
#   severity: MEDIUM
package lib.terraform.CB_TFK8S_043

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
	block.Type == "resource"
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "spec"
	some container_block in inner_block.Blocks
	container_block.Type == "container"
	some security_block in container_block.Blocks
	security_block.Type == "security_context"
	security_block.Attributes.allow_privilege_escalation == true
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The containers are not operating with the allowPrivilegeEscalation setting.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The containers must not operate with the allowPrivilegeEscalation setting.",
		"snippet": block,
	}
}
