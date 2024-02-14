# METADATA
# title: "Confirm that the PostgreSQL Database Server has the 'log_checkpoints' server parameter configured as 'ON'"
# description: "Verify that the server parameter 'log_checkpoints' is configured as 'ON' for your PostgreSQL Database Server, which confirms that checkpoint activities are logged. This setting helps maintain a comprehensive record of database operations, aiding in monitoring and troubleshooting database performance and stability."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_configuration
# custom:
#   id: CB_TFAZR_023
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_023

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
    resource.Attributes.name == "log_checkpoints"
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
        "message": "The PostgreSQL Database Server has the 'log_checkpoints' server parameter configured as 'ON'.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
	result := {
        "message": "The PostgreSQL Database Server must have the 'log_checkpoints' server parameter configured as 'ON'.",
        "snippet": block, 
    }
} 