# METADATA
# title: "Enable Managed Identity Provider for Azure Event Grid Topic"
# description: "This policy verifies whether the Managed Identity Provider is enabled for Azure Event Grid Topics. Enabling the Managed Identity Provider enhances the security and reliability of Event Grid Topics."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_topic
# custom:
#   id: CB_TFAZR_187
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_187

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
	some block in resource.Blocks
	block.Type == "identity"
	block.Attributes.type != ""
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Managed Identity Provider is enabled for Azure Event Grid Topic, enhancing security and reliability.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Enable Managed Identity Provider for Azure Event Grid Topic to enhance security and reliability.",
		"snippet": block, 
    }
}
