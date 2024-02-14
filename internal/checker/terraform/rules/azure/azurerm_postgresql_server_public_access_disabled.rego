# METADATA
# title: "Guarantee that the PostgreSQL server is configured to prevent public network accessibility"
# description: "Make certain that the PostgreSQL server is configured in a way that restricts its access to the public network, enhancing security by limiting external connections to the database. This measure helps safeguard sensitive data and confirms that only authorized users within a controlled network environment can interact with the server."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server
# custom:
#   id: CB_TFAZR_088
#   severity: LOW
package lib.terraform.CB_TFAZR_088
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

pass[block]{
    some block in input
	isvalid(block)
    block.Attributes.public_network_access_enabled == false
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "PostgreSQL server is configured to prevent public network accessibility.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "PostgreSQL server must be configured to prevent public network accessibility.",
        "snippet": block, 
    }
} 