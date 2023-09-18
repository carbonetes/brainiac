# METADATA
# title: "Confirm 'Threat Detection types' are configured as 'All'"
# description: "Validate that the configuration for 'Threat Detection' types is set to 'All', confirming comprehensive threat detection coverage."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_security_alert_policy
# custom:
#   id: CB_TFAZR_026
#   severity: HIGH
package lib.terraform.CB_TFAZR_026


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

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.disabled_alerts[_] != ""
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The 'Threat Detection types' are configured as 'All'",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The 'Threat Detection types' must be configured as 'All'",
                "snippet": block }
} 