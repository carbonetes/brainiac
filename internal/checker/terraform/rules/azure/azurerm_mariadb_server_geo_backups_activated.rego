# METADATA
# title: "Verify that geo-redundant backups are activated for the MariaDB server"
# description: "Validate MariaDB server's use of geo-redundant backups to bolster data protection and availability, even during unforeseen disruptions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mariadb_server
# custom:
#   id: CB_TFAZR_114
#   severity: LOW
package lib.terraform.CB_TFAZR_114

import future.keywords.in


isvalid(block){
	block.Type == "resource"
    "azurerm_mariadb_server" in block.Labels
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
    block.Attributes.geo_redundant_backup_enabled == true
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "The geo-redundant backups are activated for the MariaDB server.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "The geo-redundant backups must be activated for the MariaDB server.",
        "snippet": block, 
    }
} 