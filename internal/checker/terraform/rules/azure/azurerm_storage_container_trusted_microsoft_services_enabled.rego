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

import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "azurerm_storage_container" in block.Labels
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
    resource.Attributes.container_access_type == "private"
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "Blob containers have their 'Public access level' configured as 'Private'.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "Blob containers must have their 'Public access level' configured as 'Private'.",
        "snippet": block, 
    }
} 