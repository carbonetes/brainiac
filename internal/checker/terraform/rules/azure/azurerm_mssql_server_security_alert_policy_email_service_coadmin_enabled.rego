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


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "azurerm_mssql_server_security_alert_policy"
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
    resource.Attributes.email_account_admins == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Email service and co-administrators are enabled for MSSQL servers",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Email service and co-administrators must be enabled for MSSQL servers",
                "snippet": block }
} 