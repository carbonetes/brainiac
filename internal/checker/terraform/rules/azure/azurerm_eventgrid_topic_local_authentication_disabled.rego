# METADATA
# title: "Disable Local Authentication for Azure Event Grid Topic"
# description: "This policy checks that local authentication is disabled for Azure Event Grid Topics. Disabling local authentication enhances the security and reliability of Event Grid Topics."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_topic
# custom:
#   id: CB_TFAZR_188
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_188

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_eventgrid_topic" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.local_auth_enabled == false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Local Authentication is disabled for Azure Event Grid Topic, enhancing security and reliability.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Disable Local Authentication for Azure Event Grid Topic to enhance security and reliability.",
		"snippet": block, 
    }
}
