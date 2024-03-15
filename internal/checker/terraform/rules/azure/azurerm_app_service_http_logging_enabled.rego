# METADATA
# title: "Verify that HTTP logging is activated for the App service"
# description: "Take the necessary steps to activate HTTP logging for your App service, enhancing your ability to monitor and analyze web traffic effectively. This configuration confirms that vital information is captured for auditing, troubleshooting, and security analysis purposes, contributing to a more robust and informed operational environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app
# custom:
#   id: CB_TFAZR_058
#   severity: LOW
package lib.terraform.CB_TFAZR_058

import future.keywords.in

supportedResources := ["azurerm_app_service", "azurerm_linux_web_app", "azurerm_windows_web_app"]

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
    innerblock.Type == "logs"
    some http_block in innerblock.Blocks
    http_block.Type == "http_logs"
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := {
        "message": "HTTP logging is activated for the App service.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "HTTP logging must be activated for the App service.",
        "snippet": block, 
    }
} 