# METADATA
# title: "Verify AKS cluster has Network Policy configured"
# description: "By verifying that a network policy is configured, you ensure that rules and restrictions are in place for network traffic within the cluster."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFAZR_056
#   severity: LOW
package lib.terraform.CB_TFAZR_056

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
	inner_block.Type == "network_profile"
	inner_block.Attributes.network_policy != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "AKS cluster has Network Policy configured.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "AKS cluster should have Network Policy configured.",
		"snippet": block,
	}
}
