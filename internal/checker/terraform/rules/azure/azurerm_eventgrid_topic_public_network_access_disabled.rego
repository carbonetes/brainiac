# METADATA
# title: "Disable Public Network Access for Azure Event Grid Topic"
# description: "This policy verifies that public network access is disabled for Azure Event Grid Topics. Disabling public network access enhances security and restricts access to trusted networks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_topic
# custom:
#   id: CB_TFAZR_189
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_189

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
	resource.Attributes.public_network_access_enabled == false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Public network access is disabled for Azure Event Grid Topic, enhancing security.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Disable public network access for Azure Event Grid Topic to enhance security and restrict access to trusted networks.",
		"snippet": block, 
    }
}
