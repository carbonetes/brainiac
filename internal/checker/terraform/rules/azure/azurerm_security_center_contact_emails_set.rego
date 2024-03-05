# METADATA
# title: "Make certain that the 'Security contact emails' field has been configured"
# description: "Verify that the 'Security contact emails' field is configured, assuring that critical security notifications and alerts can be sent to the appropriate recipients. This step enhances incident response and cybersecurity readiness."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_contact
# custom:
#   id: CB_TFAZR_128
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_128

import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "azurerm_security_center_contact" in block.Labels
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
    block.Attributes.email != ""
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "The 'Security contact emails' field has been configured.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "The 'Security contact emails' field must be configured.",
        "snippet": block, 
    }
} 