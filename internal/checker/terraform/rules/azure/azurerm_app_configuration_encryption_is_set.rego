# METADATA
# title: "Require Encryption Block in App Configuration"
# description: "Ensure that the encryption block is configured in App Configuration for data security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration
# custom:
#   id: CB_TFAZR_165
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_165

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_app_configuration" in block.Labels
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
	some block in resource.Blocks
	block.Type == "encryption"
	block.Attributes.key_vault_key_identifier != null
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The encryption block is configured in App Configuration, enhancing data security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The encryption block must be configured in App Configuration to ensure data security.",
		"snippet": block,
	}
}
