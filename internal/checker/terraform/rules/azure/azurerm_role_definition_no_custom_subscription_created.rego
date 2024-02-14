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

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"azurerm_role_definition" in resource.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[resource]{
    some resource in input
	isvalid(resource)
    some blocks in resource.Blocks
    blocks.Type == "permissions"
    "*" in blocks.Attributes.actions
}

pass[block] {
    some block in input
	isvalid(block)
   	not fail[block]
}

passed[result] {
	some block in pass
	result := { 
		"message": "No custom subscription owner roles defined within the environment.",
        "snippet": block, 
	}
}

failed[result] {
	some block in fail
	result := { 
		"message": "Custom subscription owner roles must not be defined within the environment.",
        "snippet": block, 
	}
}