# METADATA
# title: "Make sure that AKS utilizes the Paid SKU to comply with its SLA"
# description: "Check if Azure Kubernetes Cluster (AKS) nodes utilize scale sets for better scalability and manageability"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFAZR_138
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_138

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
	resource.Attributes.sku_tier == "Standard"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "AKS is using the Paid SKU as required by its SLA.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "AKS should use the Paid SKU to comply with its SLA.",
		"snippet": block,
	}
}
