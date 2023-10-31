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

label_for_kusto_cluster[label] {
	some block in input
	block.Type == "resource"
	"azurerm_kusto_cluster" in block.Labels
	label := concat(".", block.Labels)
}

kusto_cluster_is_attached {
	some block in input
	block.Type == "resource"
	"azurerm_kusto_cluster_customer_managed_key" in block.Labels
	some label in label_for_kusto_cluster
	contains(block.Attributes.cluster_id, label)
}

pass[block] {
	some block in input
	isvalid(block)
	kusto_cluster_is_attached
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
