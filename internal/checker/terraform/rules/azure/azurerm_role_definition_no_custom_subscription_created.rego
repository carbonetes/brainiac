# METADATA
# title: "Confirm the absence of any custom subscription owner roles"
# description: "Verify that there are no custom subscription owner roles defined within the environment, confirming that only standard roles are utilized for managing subscriptions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition
# custom:
#   id: CB_TFAZR_029
#   severity: CRITICAL
package lib.terraform.CB_TFAZR_029


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "azurerm_role_definition"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "permissions"
    contains(resource.Blocks[_].Attributes.actions[_], "*")
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "No custom subscription owner roles defined within the environment.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Custom subscription owner roles must not be defined within the environment.",
                "snippet": block }
} 