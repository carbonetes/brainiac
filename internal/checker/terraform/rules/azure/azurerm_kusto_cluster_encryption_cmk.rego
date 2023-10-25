# METADATA
# title: "Confirm that Azure Data Explorer employs a customer-managed key for encryption at rest"
# description: "Validate that Azure Data Explorer enhances security by utilizing customer-managed keys for encryption at rest."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster_customer_managed_key
# custom:
#   id: CB_TFAZR_223
#   severity: LOW
package lib.terraform.CB_TFAZR_223

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_kusto_cluster_customer_managed_key" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

getLabelForKustoCluster[label] {
	some block in input
	block.Type == "resource"
	"azurerm_kusto_cluster" in block.Labels
	label := concat(".", block.Labels)
}

kustoClusterIsAttached {
	some block in input
	block.Type == "resource"
	"azurerm_kusto_cluster_customer_managed_key" in block.Labels
	contains(block.Attributes.cluster_id, getLabelForKustoCluster[label])
}

pass[block] {
	some block in input
	isvalid(block)
	kustoClusterIsAttached
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Azure Data Explorer utilizes a customer-managed key for encryption at rest.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Azure Data Explorer must utilize a customer-managed key for encryption at rest.",
		"snippet": block,
	}
}
