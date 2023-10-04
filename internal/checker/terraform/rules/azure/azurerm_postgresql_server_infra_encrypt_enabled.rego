# METADATA
# title: "Verify that infrastructure encryption is activated on the PostgreSQL server"
# description: "Confirm that infrastructure encryption is active on the PostgreSQL server, providing an additional layer of security by safeguarding sensitive data and system resources. This encryption measure enhances the protection of critical infrastructure components within your PostgreSQL environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server
# custom:
#   id: CB_TFAZR_120
#   severity: LOW
package lib.terraform.CB_TFAZR_120


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "azurerm_postgresql_server"
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
    resource.Attributes.infrastructure_encryption_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The infrastructure encryption is activated on the PostgreSQL server.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The infrastructure encryption is not activated on the PostgreSQL server.",
                "snippet": block }
} 