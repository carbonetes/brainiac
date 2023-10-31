# METADATA
# title: "Verify Machine Learning Compute Cluster Minimum Nodes Set To 0"
# description: "This policy is designed to optimize cost management and resource allocation for Machine Learning Compute Clusters by verifying that the minimum number of nodes is set to 0."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_cluster
# custom:
#   id: CB_TFAZR_140
#   severity: LOW
package lib.terraform.CB_TFAZR_140

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_machine_learning_compute_cluster" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
	some block in input
	isvalid(block)
	some innerBlock in block.Blocks
	innerBlock.Type == "scale_settings"
	innerBlock.Attributes.min_node_count == "0"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The minimum node count for the Machine Learning Compute Cluster is set to 0.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The minimum node count for the Machine Learning Compute Cluster is not set to 0.",
		"snippet": block,
	}
}