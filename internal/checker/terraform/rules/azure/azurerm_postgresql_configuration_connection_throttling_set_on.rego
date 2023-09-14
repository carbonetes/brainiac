# METADATA
# title: "Verify that the 'connection_throttling' server parameter on the PostgreSQL Database Server is configured as 'ON'"
# description: "Verify that the 'connection_throttling' server parameter on your PostgreSQL Database Server is configured as 'ON.' This setting is crucial for regulating and optimizing database connections, enhancing performance, and preventing resource exhaustion due to excessive connections. Properly managing connection throttling contributes to the overall stability and efficiency of the database server."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_configuration
# custom:
#   id: CB_TFAZR_025
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_025


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
    resource.Attributes.name == "connection_throttling"
    resource.Attributes.value == "off"
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The 'connection_throttling' server parameter on the PostgreSQL Database Server is configured as 'ON'.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The 'connection_throttling' server parameter on the PostgreSQL Database Server must be configured as 'ON'.",
                "snippet": block }
} 