# METADATA
# title: "Confirm that 'Trusted Microsoft Services' is active for interaction with the Storage Account"
# description: "Verify that the 'Trusted Microsoft Services' feature is activated within the Storage Account settings. This confirms that authorized Microsoft services can securely access the Storage Account for various operations, enhancing the account's functionality and security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
# custom:
#   id: CB_TFAZR_028
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_028

import future.keywords.in

supported_resources := ["azurerm_storage_account", "azurerm_storage_account_network_rules"]

isvalid(block) {
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[resource]{
    some resource in input
	isvalid(resource)
    some blocks in resource.Blocks
    blocks.Type == "network_rules"
    blocks.Attributes.default_action == "Deny"
    blocks.Attributes.bypass != "AzureServices"
  
}

pass[block] {
    some block in input
	isvalid(block)
   	not fail[block]
}

passed[result] {
	some block in pass
	result := { 
		"message": "The 'Trusted Microsoft Services' is active for interaction with the Storage Account.",
        "snippet": block, 
	}
}

failed[result] {
	some block in fail
	result := { 
		"message": "The 'Trusted Microsoft Services' must be active for interaction with the Storage Account.",
    	"snippet": block, 
	}
}