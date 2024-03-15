# METADATA
# title: "Verify that content type is configured for Key Vault secrets"
# description: "Confirm that content type settings are configured for Key Vault secrets, ensuring proper data handling and security"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret
# custom:
#   id: CB_TFAZR_115
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_115

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

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.content_type != null
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Content type is verified to be configured for Key Vault secrets.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Content type is not configured for Key Vault secrets as required.",
		"snippet": block,
	}
}
