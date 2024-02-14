# METADATA
# title: "Verify Azure Instance does not use basic authentication(Use SSH Key Instead)"
# description: "By avoiding basic authentication, the risk of unauthorized access to Azure instances is significantly reduced, enhancing overall system security.."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine?c=coisadenerd?c=coisadenerd#disable_password_authentication
# custom:
#   id: CB_TFAZR_001
#   severity: HIGH
package lib.terraform.CB_TFAZR_001

import future.keywords.in

supported_resources := ["azurerm_virtual_machine", "azurerm_linux_virtual_machine"]
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

fail[resource]{
    some resource in input
	isvalid(resource)
    some block in resource.Blocks
    block.Type == "os_profile_linux_config"
    block.Attributes.disable_password_authentication == false
}

pass[block] {
    some block in input
	isvalid(block)
   	not fail[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "Azure Instance does not use basic authentication.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "Azure Instance 'os_profile_linux_config' disable_password_authentication should not be set false",
        "snippet": block, 
    }
} 