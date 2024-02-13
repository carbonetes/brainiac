# METADATA
# title: "Confirm that the MySQL Database Server has 'Enforce SSL connection' configured as 'ENABLED'"
# description: "Verify that the setting 'Enforce SSL connection' is established as 'ENABLED' for your MySQL Database Server. This essential configuration enhances the security of data transmission by enforcing secure SSL connections, safeguarding sensitive information from potential threats and unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/mysql_server
# custom:
#   id: CB_TFAZR_007
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_007

import future.keywords.in


isvalid(block){
	block.Type == "resource"
    "azurerm_mysql_server" in block.Labels
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
        "message": "The MySQL Database Server has 'Enforce SSL connection' configured as 'ENABLED'.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "The MySQL Database Server must have 'Enforce SSL connection' configured as 'ENABLED'.",
        "snippet": block, 
    }
} 