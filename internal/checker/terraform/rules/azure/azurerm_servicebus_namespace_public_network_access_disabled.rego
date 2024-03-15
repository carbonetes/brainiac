# METADATA
# title: "Verify Azure Service Bus Public Network Access Disabled"
# description: "This policy ensures that 'public network access enabled' is set to 'False' for Azure Service Bus to enhance security by restricting access from public networks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace
# custom:
#   id: CB_TFAZR_200
#   severity: HIGH
package lib.terraform.CB_TFAZR_200

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_servicebus_namespace" in block.Labels
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
		"message": "Azure Service Bus restricts public network access, enhancing security.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Service Bus should have 'public network access enabled' set to 'False' to restrict access from public networks and enhance security.",
		"snippet": block, 
    }
}
