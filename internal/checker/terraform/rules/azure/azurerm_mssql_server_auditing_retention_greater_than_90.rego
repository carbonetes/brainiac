# METADATA
# title: "Verify that the retention period for SQL servers' auditing is set to more than 90 days"
# description: "Confirm that the retention duration for auditing in SQL servers is configured to exceed 90 days. This measure enhances data security and compliance by retaining audit logs for an extended period, ensuring a comprehensive record of activities within SQL servers is maintained."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server
# custom:
#   id: CB_TFAZR_020
#   severity: HIGH
package lib.terraform.CB_TFAZR_020

import future.keywords.in

supported_resources := ["azurerm_mssql_server", "azurerm_sql_server"]

isvalid(block){
	block.Type == "resource"
    some label in block.Labels
    label in supported_resources
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
    some inner_block in resource.Blocks
    inner_block.Type == "extended_auditing_policy"
    to_number(inner_block.Attributes.retention_in_days) >= 90
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "The retention period for SQL servers' auditing is set to more than 90 days.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "The retention period for SQL servers' auditing must be set to more than 90 days.",
        "snippet": block, 
    }
} 