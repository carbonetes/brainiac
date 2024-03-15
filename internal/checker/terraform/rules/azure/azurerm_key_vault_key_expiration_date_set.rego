# METADATA
# title: "Confirm that an expiration date has been specified for all keys"
# description: "Please verify that expiration dates have been assigned to all keys in the system. This practice enhances security by automatically invalidating keys after a designated period, mitigating the risk associated with prolonged access to sensitive resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key.html
# custom:
#   id: CB_TFAZR_010
#   severity: CRITICAL
package lib.terraform.CB_TFAZR_010

import future.keywords.in

isvalid(block){
	block.Type == "resource"
   "azurerm_key_vault_key" in block.Labels
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
    resource.Attributes.expiration_date != ""
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "An expiration date has been specified for all keys",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "An expiration date must be specified for all keys",
        "snippet": block, 
    }
} 