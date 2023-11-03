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
	regex.match(`^[a-z0-9]{3,24}$`, block.Attributes.name)
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Storage Accounts adhere to the naming rules.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Storage Accounts do not adhere to the naming rules.",
		"snippet": block,
	}
}
