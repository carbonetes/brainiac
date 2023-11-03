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

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_storage_account" in block.Labels
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
	valid_value := ["TLS1_2", "TLS1_3"]
	block.Attributes.min_tls_version in valid_value
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Storage Account is using the latest version of TLS encryption.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Storage Account is not using the latest version of TLS encryption.",
		"snippet": block,
	}
}
