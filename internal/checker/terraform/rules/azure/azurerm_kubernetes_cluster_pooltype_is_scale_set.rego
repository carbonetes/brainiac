# METADATA
# title: "Verify that Azure Kubernetes Cluster (AKS) nodes are configured to use scale sets"
# description: "Check if Azure Kubernetes Cluster (AKS) nodes utilize scale sets for better scalability and manageability"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFAZR_137
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_137

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
	some innerblock in resource.Blocks
	innerblock.Type == "default_node_pool"
	innerblock.Attributes.type == "AvailabilitySet"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Kubernetes Cluster (AKS) nodes are configured to use scale sets.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Kubernetes Cluster (AKS) nodes should use scale sets for better scalability and manageability.",
		"snippet": block,
	}
}
