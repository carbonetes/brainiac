# METADATA
# title: "Verify Storage Account is using the latest version of TLS encryption"
# description: "This policy is designed to ensure the security and data protection of Azure Storage Accounts by verifying that the latest version of Transport Layer Security (TLS) encryption is in use."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
# custom:
#   id: CB_TFAZR_012
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_012

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "azurerm_storage_account"
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
	validValue := ["TLS1_2", "TLS1_3"]
	block.Attributes.min_tls_version == validValue[_]
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "The Storage Account is using the latest version of TLS encryption.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "The Storage Account is not using the latest version of TLS encryption.",
		"snippet": block,
	}
}
