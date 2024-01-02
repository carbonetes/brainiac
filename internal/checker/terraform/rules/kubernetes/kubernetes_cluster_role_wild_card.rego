# METADATA
# title: "Limit Wildcard Use in Roles and ClusterRoles"
# description: "This policy encourages the minimal use of wildcards in Kubernetes Roles and ClusterRoles. Limiting wildcard usage enhances security by providing more fine-grained control over permissions."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role
# custom:
#   id: CB_TFK8S_033
#   severity: MEDIUM
package lib.terraform.CB_TFK8S_033

import future.keywords.in

isvalid(block) {
	supported_resources := [
		"kubernetes_role",
		"kubernetes_role_v1",
		"kubernetes_cluster_role",
		"kubernetes_cluster_role_v1",
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
	block.Type == "rule"
	some invalid_value in ["*", null, ""]
    some value in block.Attributes.api_groups
	invalid_value == value
    count(block.Attributes.api_groups) != 0
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "rule"
	some invalid_value in ["*", null, ""]
    some value in block.Attributes.resources
	invalid_value == value
    count(block.Attributes.resources) != 0
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "rule"
	some invalid_value in ["*", null, ""]
    some value in block.Attributes.verbs
	invalid_value == value
    count(block.Attributes.verbs) != 0
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Roles and ClusterRoles have been configured with minimal wildcard usage, improving security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Wildcards are excessively used in Roles and ClusterRoles. It is recommended to limit wildcard usage for enhanced security and precise permission control.",
		"snippet": block,
	}
}
