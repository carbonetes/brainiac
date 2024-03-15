# METADATA
# title: "Disable Local Authentication for Azure Service Bus"
# description: "This policy ensures that local authentication is disabled for Azure Service Bus, enhancing security by reducing potential attack vectors."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace
# custom:
#   id: CB_TFAZR_199
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_199

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
		"message": "Azure Service Bus has local authentication disabled, enhancing security.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Service Bus should have local authentication disabled to enhance security by reducing potential attack vectors.",
		"snippet": block, 
    }
}
