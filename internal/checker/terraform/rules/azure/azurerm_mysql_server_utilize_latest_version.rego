# METADATA
# title: "Verify that MySQL is utilizing the most up-to-date TLS encryption version"
# description: "This confirms that MySQL is configured to utilize the most recent iteration of TLS encryption, enhancing the security of data transmissions between the server and clients by adopting the latest encryption standards and protocols."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/mysql_server
# custom:
#   id: CB_TFAZR_037
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_037
import future.keywords.in


isvalid(block){
	block.Type == "resource"
    "azurerm_mysql_server" in block.Labels
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
    resource.Attributes.ssl_minimal_tls_version_enforced == "TLS1_2"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "MySQL is utilizing the most up-to-date TLS encryption version.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "MySQL must utilize the most up-to-date TLS encryption version.",
                "snippet": block }
} 