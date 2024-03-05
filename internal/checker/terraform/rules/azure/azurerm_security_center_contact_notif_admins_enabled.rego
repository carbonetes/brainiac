# METADATA
# title: "Activate email notifications for admins regarding high severity alerts"
# description: "Enable the email notification feature to inform administrators about high severity alerts. This verifies that critical issues are promptly communicated to the appropriate personnel for immediate attention."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_contact.html
# custom:
#   id: CB_TFAZR_004
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_004

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
    resource.Attributes.alerts_to_admins == true
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "Email Notifications for Admins Regarding High Severity Alerts are activated.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "Email Notifications for Admins Regarding High Severity Alerts must be activated.",
        "snippet": block, 
    }
} 