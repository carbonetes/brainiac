# METADATA
# title: "Verify that Azure Batch account uses key vault to encrypt data"
# description: "This policy is designed to enhance the security and data protection of Azure Batch accounts by verifying that data within the account is encrypted using Azure Key Vault."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/batch_account
# custom:
#   id: CB_TFAZR_041
#   severity: LOW
package lib.terraform.CB_TFAZR_041

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_batch_account" in block.Labels
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
	innerBlock.Type == "key_vault_reference"
	innerBlock.Attributes.id != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Batch account uses key vault to encrypt data.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Batch account does not use key vault to encrypt data.",
		"snippet": block,
	}
}