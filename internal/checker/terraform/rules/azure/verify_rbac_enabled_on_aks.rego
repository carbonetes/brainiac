# METADATA
# title: "Verify RBAC is enabled on AKS clusters"
# description: "Enabling RBAC on AKS clusters means setting up and managing roles and role assignments to control user and service access to cluster resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFAZR_054
#   severity: HIGH
package lib.terraform.CB_TFAZR_054

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_kubernetes_cluster" in block.Labels
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
	some inner_block in resource.Blocks
	inner_block.Type == "role_based_access_control"
	inner_block.Attributes.enabled == true
}

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.role_based_access_control_enabled == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "RBAC is enabled on AKS clusters.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "AKS 'role_based_access_control' should be enabled.",
		"snippet": block,
	}
}
