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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "azurerm_security_center_contact"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.alerts_to_admins == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Email Notifications for Admins Regarding High Severity Alerts are activated.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Email Notifications for Admins Regarding High Severity Alerts must be activated.",
                "snippet": block }
} 