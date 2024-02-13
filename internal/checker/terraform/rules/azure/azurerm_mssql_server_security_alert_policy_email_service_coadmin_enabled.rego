# METADATA
# title: "Confirm that the 'Email service and co-administrators' are set to 'Enabled' for MSSQL servers"
# description: "Examine the settings of MSSQL servers to verify that 'Email service and co-administrators' have been configured as 'Enabled,' allowing for effective email services and co-administrative functions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_security_alert_policy.html
# custom:
#   id: CB_TFAZR_006
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_006

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
    resource.Attributes.email_account_admins == true
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "Email service and co-administrators are enabled for MSSQL servers.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "Email service and co-administrators must be enabled for MSSQL servers.",
        "snippet": block, 
    }
} 