# METADATA
# title: "Verify that the connection_throttling server parameter on the PostgreSQL Database Server is enabled"
# description: "Verify that the connection_throttling server parameter on your PostgreSQL Database Server is activated. This setting is crucial for regulating and optimizing database connections, enhancing performance, and preventing resource exhaustion due to excessive connections. Properly managing connection throttling contributes to the overall stability and efficiency of the database server."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_configuration
# custom:
#   id: CB_TFAZR_025
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_025

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
    resource.Attributes.name == "connection_throttling"
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
        "message": "The connection_throttling server parameter on the PostgreSQL Database Server is configured as 'ON'.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "The connection_throttling server parameter on the PostgreSQL Database Server must be configured as 'ON'.",
        "snippet": block, 
    }
} 