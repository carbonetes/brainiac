# METADATA
# title: "Confirm that the PostgreSQL Database Server has 'Enforce SSL connection' configured as 'ENABLED'"
# description: "Confirm that the 'Enforce SSL connection' setting is configured as 'ENABLED' for your PostgreSQL Database Server. This critical configuration ensures that all data transmissions between the server and clients are securely encrypted using SSL, bolstering the protection of sensitive information and enhancing overall system security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server
# custom:
#   id: CB_TFAZR_009
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_009

import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "azurerm_postgresql_server" in block.Labels
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
    resource.Attributes.ssl_enforcement_enabled == true
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "The PostgreSQL Database Server has 'Enforce SSL connection' configured as 'ENABLED'.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "The PostgreSQL Database Server must have 'Enforce SSL connection' configured as 'ENABLED'.",
        "snippet": block, 
    }
} 