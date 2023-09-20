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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "azurerm_mssql_server"
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
    to_number(resource.Attributes.minimum_tls_version) == 1.2
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "MSSQL is utilizing the most up-to-date TLS encryption version.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "MSSQL must utilize the most up-to-date TLS encryption version.",
                "snippet": block }
} 