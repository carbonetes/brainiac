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

import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "azurerm_mssql_server_security_alert_policy" in block.Labels
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
    "email_addresses" in object.keys(resource.Attributes)
    resource.Attributes.email_addresses != ""
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "MSSQL servers have the 'Send Alerts To' feature activated.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "MSSQL servers must have the 'Send Alerts To' feature activated.",
        "snippet": block, 
    }
} 