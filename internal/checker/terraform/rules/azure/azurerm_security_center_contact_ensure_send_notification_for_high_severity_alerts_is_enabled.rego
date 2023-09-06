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


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "azurerm_security_center_contact"
}

has_attribute(key, value) {
    _ = key[value]
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
    has_attribute(resource.Attributes, "alert_notifications")
    resource.Attributes.alert_notifications == true
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "alert_notifications")
    resource.Attributes.alert_notifications == "true"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Email notification function for high severity alerts is active",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "email notification function for high severity alerts is not active",
                "snippet": block }
} 