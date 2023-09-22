# METADATA
# title: "Make certain that function apps have authentication activated"
# description: "Activating authentication for function apps establishes a secure access control mechanism, verifying user identities and protecting against unauthorized access, thereby enhancing application security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app
# custom:
#   id: CB_TFAZR_043
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_043

import future.keywords.in


isvalid(block){
	block.Type == "resource"
    "azurerm_function_app" in block.Labels
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
    some block in resource.Blocks
    block.Type == "auth_settings"
    block.Attributes.enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The function apps have authentication activated.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The function apps must have authentication activated.",
                "snippet": block }
} 