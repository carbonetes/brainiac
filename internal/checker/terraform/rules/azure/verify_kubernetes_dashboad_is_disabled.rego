# METADATA
# title: "Verify Kubernetes Dashboard is disabled"
# description: "Disabling the Dashboard helps prevent potential security vulnerabilities and unauthorized access to cluster resources via the web interface."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFAZR_059
#   severity: LOW
package lib.terraform.CB_TFAZR_059

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

fail[resource] {
	some resource in input
	isvalid(resource)
	some inner_block in resource.Blocks
	inner_block.Type == "addon_profile"
	some addon_block in inner_block.Blocks
	addon_block.Type == "kube_dashboard"
	addon_block.Attributes.enabled == true
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Kubernetes Dashboard is disabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Kubernetes Dashboard should be disabled.",
		"snippet": block,
	}
}
