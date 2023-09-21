# METADATA
# title: "Verify that Azure Data Explorer uses disk encryption"
# description: "This policy is designed to enhance the security and data protection of Azure Data Explorer by verifying that disk-level encryption is applied."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster
# custom:
#   id: CB_TFAZR_039
#   severity: LOW
package lib.terraform.CB_TFAZR_039

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "azurerm_kusto_cluster"
}

resource[resource] {
	block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
	block := fail[_]
	resource := concat(".", block.Labels)
}

pass[block] {
	block := input[_]
	isvalid(block)
	block.Attributes.enable_disk_encryption == true
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "Azure Data Explorer uses disk encryption.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "Azure Data Explorer does not use disk encryption.",
		"snippet": block,
	}
}