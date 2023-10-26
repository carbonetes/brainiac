# METADATA
# title: "Verify that Azure data factories are encrypted with a customer-managed key"
# description: "This policy is designed to enhance the security and data protection of Azure Data Factories by verifying that they are encrypted with customer-managed keys."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory
# custom:
#   id: CB_TFAZR_234
#   severity: LOW
package lib.terraform.CB_TFAZR_234

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_data_factory" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_data_factory[label] {
	some resource in input
	resource.Type == "resource"
	"azurerm_data_factory" in resource.Labels
	label := concat(".", resource.Labels)
}

is_data_factory_attached {
	some block in input
	block.Type == "resource"
	"azurerm_data_factory_linked_service_key_vault" in block.Labels
	some label in label_for_data_factory
	contains(block.Attributes.data_factory_name, label)
}

pass[block] {
	some block in input
	isvalid(block)
	is_data_factory_attached
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Data Factory is encrypted with a customer-managed key.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Data Factory is not encrypted with a customer-managed key.",
		"snippet": block,
	}
}