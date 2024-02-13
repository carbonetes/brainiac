# METADATA
# title: "Specify that Azure Kubernetes Cluster (AKS) nodes must support a minimum of 50 pods"
# description: "Verify that Azure Kubernetes Cluster (AKS) nodes are configured to accommodate at least 50 pods to meet application requirements"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFAZR_136
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_136

import future.keywords.in

supportedResources := ["azurerm_kubernetes_cluster", "azurerm_kubernetes_cluster_node_pool"]

isvalid(block) {
	block.Type == "resource"
	some label in block.Labels
	label in supportedResources
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
	to_number(innerblock.Attributes.max_pods) >= 50
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Kubernetes Cluster (AKS) nodes support a minimum of 50 pods.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Kubernetes Cluster (AKS) nodes must support a minimum of 50 pods.",
		"snippet": block,
	}
}
