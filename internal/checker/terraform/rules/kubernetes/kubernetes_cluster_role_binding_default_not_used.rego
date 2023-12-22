# METADATA
# title: "Prevent Active Usage of Default Service Accounts"
# description: "This policy aims to discourage the active usage of default service accounts. Employing default service accounts for critical tasks can pose security risks, and it is recommended to create and use service accounts with the least privilege required for specific functions."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding
# custom:
#   id: CB_TFK8S_030
#   severity: LOW
package lib.terraform.CB_TFK8S_030

import future.keywords.in

isvalid(block) {
	supported_resources := [
		"kubernetes_cluster_role_binding",
		"kubernetes_cluster_role_binding_v1",
		"kubernetes_role_binding",
		"kubernetes_role_binding_v1",
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
    some block in resource.Blocks
    block.Type == "subject"
    block.Attributes.name == "default"
}

fail[resource] {
    some resource in input
    isvalid(resource)
    some block in resource.Blocks
    block.Type == "subject"
    block.Attributes.kind == "ServiceAccount"
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "No active usage of default service accounts is identified, promoting a more secure configuration.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Active usage of default service accounts is detected. It is advised to refrain from utilizing default service accounts actively to enhance overall security.",
		"snippet": block,
	}
}
