# METADATA
# title: "Verify that the Key Vault key is supported by a Hardware Security Module (HSM)"
# description: "Confirm that the Key Vault key benefits from the added security provided by being backed by a Hardware Security Module (HSM). HSMs are dedicated hardware devices designed to safeguard cryptographic keys and perform cryptographic operations securely, enhancing key protection"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key
# custom:
#   id: CB_TFAZR_111
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_111

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_key_vault_key" in block.Labels
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
	resource.Attributes.key_type == "RSA-HSM"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Key Vault key is verified to be supported by a Hardware Security Module (HSM).",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Key Vault key is not supported by a Hardware Security Module (HSM) as required.",
		"snippet": block,
	}
}
