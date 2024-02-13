# METADATA
# title: "Make certain that public IP addresses are not assigned to AKS cluster nodes"
# description: "Verify that public IP addresses are not allocated to AKS cluster nodes to enhance security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFAZR_177
#   severity: LOW
package lib.terraform.CB_TFAZR_177

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

fail[block] {
	some block in input
	isvalid(block)
	some innerBlock in block.Blocks
    innerBlock.Type == "default_node_pool"
	innerBlock.Attributes.enable_node_public_ip == true
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "public IP addresses are not assigned to AKS cluster nodes.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "public IP addresses must not be assigned to AKS cluster nodes.",
		"snippet": block,
	}
}
