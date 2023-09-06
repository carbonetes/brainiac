# METADATA
# title: "Verify that the key vault is recoverable"
# description: "This policy is designed to ensure the recoverability and resilience of a key vault system by verifying that proper measures are in place for data recovery and restoration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key
# custom:
#   id: CB_TFAZR_005
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_005

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "azurerm_key_vault"
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
	block.Attributes.purge_protection_enabled == true
	block.Attributes.soft_delete_enabled == true
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "The key vault is recoverable. Proper measures are in place for data recovery and restoration.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "The key vault is not recoverable. Verify that purge protection and soft delete are enabled.",
		"snippet": block,
	}
}
