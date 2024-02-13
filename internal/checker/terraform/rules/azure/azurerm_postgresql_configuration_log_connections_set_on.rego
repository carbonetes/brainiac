# METADATA
# title: "Confirm that the 'log_connections' server parameter is configured as 'ON' for the PostgreSQL Database Server"
# description: "Verify that the 'log_connections' server parameter is correctly configured as 'ON' for your PostgreSQL Database Server to confirm proper connection logging and monitoring. This setting is essential for maintaining a comprehensive audit trail of database connections and activities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_configuration
# custom:
#   id: CB_TFAZR_024
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_024

import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "azurerm_postgresql_configuration" in block.Labels
}

resource[resource] {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    some block in fail
	resource := concat(".", block.Labels)
} 

fail[resource]{
    some resource in input
	isvalid(resource)
    resource.Attributes.name == "log_connections"
    resource.Attributes.value == "off"
}

pass[block] {
    some block in input
	isvalid(block)
   	not fail[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "The 'log_connections' server parameter is configured as 'ON' for the PostgreSQL Database Server.",
        "snippet": block, 
        }
}

failed[result] {
    some block in fail
	result := { 
        "message": "The 'log_connections' server parameter must be configured as 'ON' for the PostgreSQL Database Server.",
        "snippet": block, 
    }
} 