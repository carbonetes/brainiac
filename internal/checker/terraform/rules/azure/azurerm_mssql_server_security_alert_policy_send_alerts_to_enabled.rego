# METADATA
# title: "Confirm that MSSQL servers have the 'Send Alerts To' feature activated"
# description: "lease validate that the 'Send Alerts To' option is turned on for MSSQL servers. This setting verifies that alerts and notifications are actively sent, enabling timely awareness of critical events and issues within the server environment for prompt action and resolution."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_security_alert_policy
# custom:
#   id: CB_TFAZR_017
#   severity: HIGH
package lib.terraform.CB_TFAZR_017


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "azurerm_mssql_server_security_alert_policy"
}

has_attribute(key, value){
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
    has_attribute(resource.Attributes, "email_addresses")
    resource.Attributes.email_addresses != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "MSSQL servers have the 'Send Alerts To' feature activated.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "MSSQL servers must have the 'Send Alerts To' feature activated.",
                "snippet": block }
} 