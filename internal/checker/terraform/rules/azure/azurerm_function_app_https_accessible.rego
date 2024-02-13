# METADATA
# title: "Confirm that Function apps can only be reached via HTTPS for enhanced security"
# description: "Verify that Function apps are exclusively available through HTTPS for increased security, confirming that all interactions with the apps are encrypted and protected."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# custom:
#   id: CB_TFAZR_095
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_095

import future.keywords.in


isvalid(block){
	block.Type == "resource"
    "azurerm_app_service" in block.Labels
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
    block.Attributes.https_only == true
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "The Function apps is set to be reached via HTTPS only for enhanced security.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "The Function apps must only be exclusively available through HTTPS for increased security.",
        "snippet": block, 
    }
} 