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


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "azurerm_postgresql_configuration"
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
    resource.Attributes.name == "log_checkpoints"
    resource.Attributes.value == "off"
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The PostgreSQL Database Server has the 'log_checkpoints' server parameter configured as 'ON'.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The PostgreSQL Database Server must have the 'log_checkpoints' server parameter configured as 'ON'.",
                "snippet": block }
} 