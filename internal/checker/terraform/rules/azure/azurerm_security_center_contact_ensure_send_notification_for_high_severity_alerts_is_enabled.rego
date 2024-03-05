# METADATA
# title: "Confirm that the email notification function for high severity alerts is set to active"
# description: "Confirm that the option to activate email notifications for high-severity alerts has been turned on to ensure timely notifications. This setting verifies that important alerts are promptly communicated via email."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_contact.html
# custom:
#   id: CB_TFAZR_002
#   severity: LOW
package lib.terraform.CB_TFAZR_002

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

pass[resource]{
    some resource in input
	isvalid(resource)
    resource.Attributes.alert_notifications == true
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "Email notification function for high severity alerts is active.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "Email notification function for high severity alerts is not active.",
        "snippet": block, 
    }
} 