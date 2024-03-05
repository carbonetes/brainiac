# METADATA
# title: "Confirm that MSSQL employs the most up-to-date TLS encryption version"
# description: "Confirm the utilization of the latest TLS encryption protocol within MSSQL for enhanced security and data protection. Verify that MSSQL is configured to utilize the most current TLS encryption standards to safeguard sensitive information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server
# custom:
#   id: CB_TFAZR_034
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_034

import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "azurerm_mssql_server" in block.Labels
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
    block.Attributes.minimum_tls_version == "1.2"
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "MSSQL is utilizing the most up-to-date TLS encryption version.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "MSSQL must utilize the most up-to-date TLS encryption version.",
        "snippet": block, 
    }
}