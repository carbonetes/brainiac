# METADATA
# title: "Verify AKS Cluster with Azure CNI Networking Enabled"
# description: "This policy ensures that an AKS (Azure Kubernetes Service) cluster is configured with Azure Container Networking Interface (CNI) for efficient networking and resource management."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFAZR_227
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_227

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"azurerm_kubernetes_cluster" in resource.Labels
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
	block.Type == "network_profile"
	block.Attributes.network_plugin in ["azure", "Azure"]
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "AKS cluster has Azure CNI networking correctly enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure CNI networking is not enabled on the AKS cluster.",
		"snippet": block,
	}
}