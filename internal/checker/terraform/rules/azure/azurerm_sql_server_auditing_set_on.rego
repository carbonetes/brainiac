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

import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "azurerm_sql_server" in block.Labels
}

resource[resource] {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    some block in fail
	resource := concat(".", block.Labels)
} 


label_for_mssql_server[label]{
	some resource in input
    resource.Type == "resource"
    "azurerm_mssql_server" in resource.Labels
    some inner_block in resource.Blocks
    inner_block.Type == "extended_auditing_policy" 
    label := concat(".", resource.Labels)
}

policy_is_attached{
    some resource in input
    resource.Type == "resource"
    "azurerm_mssql_server_extended_auditing_policy" in resource.Labels
    some label in label_for_mssql_server
    contains(resource.Attributes.server_id, label)
}

pass[resource]{
    some resource in input
	isvalid(resource)
    some inner_block in resource.Blocks
    inner_block.Type == "extended_auditing_policy" 
    policy_is_attached
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "SQL servers have their Auditing setting enabled.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "SQL servers must have their Auditing setting enabled.",
        "snippet": block, 
    }
} 