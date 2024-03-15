# METADATA
# title: "Confirm that the Function app is utilizing the latest 'HTTP Version' if it is in use"
# description: "Verify that the Function app, when utilized, operates with the most up-to-date 'HTTP Version.' This practice confirms optimal performance and compatibility with modern web standards, enhancing the functionality of your application for improved user experience and security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app
# custom:
#   id: CB_TFAZR_070
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_070

import future.keywords.in

supportedResources := ["azurerm_function_app", "azurerm_function_app_slot"]

isvalid(block){
	block.Type == "resource"
    some label in block.Labels
    label in supportedResources
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
    some innerblock in block.Blocks
    innerblock.Type == "site_config"
    innerblock.Attributes.http2_enabled == true
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "The Function app is utilizing the latest 'HTTP Version' if it is in use.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "The Function app must utilize the latest 'HTTP Version' if it is in use.",
        "snippet": block, 
    }
} 