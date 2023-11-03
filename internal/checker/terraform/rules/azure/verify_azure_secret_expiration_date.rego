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

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_key_vault_secret" in block.Labels
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
	block.Attributes.expiration_date != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "All secrets have a valid expiration date set.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "All secrets don't have a valid expiration date set.",
		"snippet": block,
	}
}
