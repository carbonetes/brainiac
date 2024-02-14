# METADATA
# title: "Verify that soft delete is enabled for the Key Vault"
# description: "Confirm that the Key Vault has activated soft delete, providing a safety net against accidental or unauthorized deletion of data or keys by allowing recovery within a defined retention period"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/2.41.0/docs/resources/key_vault
# custom:
#   id: CB_TFAZR_110
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_110

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
	resource.Attributes.soft_delete_enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "Soft delete is verified to be enabled for the Key Vault.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Soft delete is not enabled for the Key Vault as required.",
		"snippet": block,
    }
}