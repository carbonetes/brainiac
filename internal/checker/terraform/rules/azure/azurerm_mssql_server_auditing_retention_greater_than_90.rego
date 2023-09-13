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

supportedResources := ["azurerm_mssql_server", "azurerm_sql_server"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
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
    resource.Blocks[_].Type == "extended_auditing_policy"
    to_number(resource.Blocks[_].Attributes.retention_in_days) >= 90
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The retention period for SQL servers' auditing is set to more than 90 days.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The retention period for SQL servers' auditing must be set to more than 90 days.",
                "snippet": block }
} 