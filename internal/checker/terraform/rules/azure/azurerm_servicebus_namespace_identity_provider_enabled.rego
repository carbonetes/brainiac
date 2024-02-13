# METADATA
# title: "Enable Managed Identity Provider for Azure Service Bus"
# description: "This policy ensures that the Managed Identity Provider is enabled for Azure Service Bus, enhancing security and access control."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace
# custom:
#   id: CB_TFAZR_198
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_198

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
		"message": "Managed Identity Provider is enabled for Azure Service Bus, enhancing security and access control.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Service Bus should have Managed Identity Provider enabled to enhance security and access control.",
		"snippet": block, 
    }
}
