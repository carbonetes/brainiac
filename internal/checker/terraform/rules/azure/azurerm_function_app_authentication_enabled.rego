# METADATA
# title: "Make certain that function apps have authentication activated"
# description: "Activating authentication for function apps establishes a secure access control mechanism, verifying user identities and protecting against unauthorized access, thereby enhancing application security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app
# custom:
#   id: CB_TFAZR_043
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_043

import future.keywords.in


isvalid(block){
	block.Type == "resource"
    "azurerm_function_app" in block.Labels
}

resource[resource] {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    some block in fail
	resource := concat(".", block.Labels)
} 

pass[block]{
    some block in input
	isvalid(block)
    some block_auth in block.Blocks
    block_auth.Type == "auth_settings"
    block_auth.Attributes.enabled == true
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "The function apps have authentication activated.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "The function apps must have authentication activated.",
        "snippet": block, 
    }
} 