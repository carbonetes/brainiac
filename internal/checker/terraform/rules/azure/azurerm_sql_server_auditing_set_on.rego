# METADATA
# title: "Verify that SQL servers have their Auditing setting enabled"
# description: "Verify that the Auditing setting for SQL servers is enabled, confirming that security and compliance standards are met by keeping auditing functionality turned on. This configuration enhances data monitoring and governance within SQL server environments."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_server
# custom:
#   id: CB_TFAZR_021
#   severity: HIGH
package lib.terraform.CB_TFAZR_021

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "azurerm_sql_server"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 


getLabelForMssqlServer[label]{
	resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "azurerm_mssql_server"
    resource.Blocks[_].Type == "extended_auditing_policy" 
    label := concat(".", resource.Labels)
}

policyIsAttached{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "azurerm_mssql_server_extended_auditing_policy"
    contains(resource.Attributes.server_id, getLabelForMssqlServer[_])
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "extended_auditing_policy" 
    policyIsAttached
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "SQL servers have their Auditing setting enabled.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "SQL servers must have their Auditing setting enabled.",
                "snippet": block }
} 