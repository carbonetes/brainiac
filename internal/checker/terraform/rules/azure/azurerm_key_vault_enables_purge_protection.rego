# METADATA
# title: "Verify that purge protection is enabled for the Key Vault"
# description: "Confirm that the Key Vault has activated purge protection, enhancing data security by preventing accidental or unauthorized permanent deletion of sensitive information"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
# custom:
#   id: CB_TFAZR_109
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_109

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_key_vault" in block.Labels
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
    resource.Attributes.purge_protection_enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "Purge protection is verified to be enabled for the Key Vault.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Purge protection is not enabled for the Key Vault as required.",
		"snippet": block,
    }
}