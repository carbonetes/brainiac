# METADATA
# title: "Verify that Azure Data Explorer uses double encryption"
# description: "This policy is designed to enhance the security and data protection of Azure Data Explorer by verifying that data is double encrypted."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster
# custom:
#   id: CB_TFAZR_040
#   severity: LOW
package lib.terraform.CB_TFAZR_040

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_kusto_cluster" in block.Labels
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
	block.Attributes.double_encryption_enabled == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Data Explorer uses double encryption.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Data Explorer does not use double encryption.",
		"snippet": block,
	}
}