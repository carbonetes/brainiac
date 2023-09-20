# METADATA
# title: "Confirm that the 'public network access enabled' setting for MySQL servers is configured as 'False' to enhance security"
# description: "Verify that the 'public network access enabled' option for MySQL servers is appropriately set to 'False' in order to bolster security measures. This setting confirms that the server is not accessible from public networks, enhancing data protection and preventing unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server
# custom:
#   id: CB_TFAZR_036
#   severity: LOW
package lib.terraform.CB_TFAZR_036


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "azurerm_mysql_server"
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
    resource.Attributes.public_network_access_enabled == false
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The 'public network access enabled' setting for MySQL servers is configured as 'False' to enhance security.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The 'public network access enabled' setting for MySQL servers must be configured as 'False' to enhance security.",
                "snippet": block }
} 