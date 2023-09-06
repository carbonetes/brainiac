# METADATA
# title: "Verify that the expiration date is set on all secrets"
# description: "This policy is designed to enhance the security and management of secrets by verifying that an expiration date is properly set for all stored secrets."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret
# custom:
#   id: CB_TFAZR_003
#   severity: CRITICAL
package lib.terraform.CB_TFAZR_003

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "azurerm_key_vault_secret"
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
	block.Attributes.expiration_date != ""
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "All secrets have a valid expiration date set.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "All secrets don't have a valid expiration date set.",
		"snippet": block,
	}
}
