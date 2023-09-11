# METADATA
# title: "Verify Storage Accounts adhere to the naming rules"
# description: "This policy is designed to enforce consistent and secure naming conventions for Azure Storage Accounts by verifying that storage accounts adhere to the established naming rules."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
# custom:
#   id: CB_TFAZR_008
#   severity: LOW
package lib.terraform.CB_TFAZR_008

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
	regex.match("^[a-z0-9]{3,24}$", block.Attributes.name)
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "The Storage Accounts adhere to the naming rules.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "Storage Accounts do not adhere to the naming rules.",
		"snippet": block,
	}
}
