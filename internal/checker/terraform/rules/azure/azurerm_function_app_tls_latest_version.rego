# METADATA
# title: "Confirm that the Function app utilizes the most recent TLS encryption version"
# description: "Verify that the Function app is configured to utilize the latest version of TLS encryption, enhancing the security of data transmissions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app
# custom:
#   id: CB_TFAZR_161
#   severity: LOW
package lib.terraform.CB_TFAZR_161

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
    some innerblock in block.Blocks
    innerblock.Type == "site_config"
    innerblock.Attributes.min_tls_version == "1.2"
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "The Function app is utilizing the recent TLS encryption version if it is in use.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "The Function app must utilize the recent TLS encryption version if it is in use.",
        "snippet": block, 
    }
} 