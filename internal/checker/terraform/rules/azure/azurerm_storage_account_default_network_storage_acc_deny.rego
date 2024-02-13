# METADATA
# title: "Confirm that the default network access rule for Storage Accounts is configured to deny access"
# description: "Please validate that the default network access rule for Storage Accounts is configured to block access. This measure is essential for enhancing the security of your storage resources by denying any unauthorized network traffic by default, ensuring data protection and system integrity."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
# custom:
#   id: CB_TFAZR_011
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_011

import future.keywords.in

supported_resources := ["azurerm_storage_account", "azurerm_storage_account_network_rules"]

isvalid(block){
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

pass[resource]{
    some resource in input
	isvalid(resource)
    some inner_blocks in resource.Blocks
    inner_blocks.Type == "network_rules"
    inner_blocks.Attributes.default_action == "Deny"
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "The default network access rule for Storage Accounts is configured to deny access.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "The default network access rule for Storage Accounts must be configured to deny access.",
        "snippet": block, 
    }
} 