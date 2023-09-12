# METADATA
# title: "Confirm that blob containers have their 'Public access level' configured as 'Private'"
# description: "Please verify that the 'Public access level' for blob containers is set to 'Private.' This setting restricts public access to the containers, enhancing data security by ensuring that only authorized users have access to the stored information, mitigating potential privacy and security risks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container
# custom:
#   id: CB_TFAZR_014
#   severity: CRITICAL
package lib.terraform.CB_TFAZR_014

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "azurerm_storage_container"
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
    resource.Attributes.container_access_type == "private"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Blob containers have their 'Public access level' configured as 'Private'.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Blob containers must have their 'Public access level' configured as 'Private'.",
                "snippet": block }
} 