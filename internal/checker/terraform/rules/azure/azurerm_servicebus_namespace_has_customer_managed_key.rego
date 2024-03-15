# METADATA
# title: "Enforce Customer-Managed Key Encryption for Azure Service Bus"
# description: "This policy mandates the use of customer-managed keys for encrypting data in Azure Service Bus, thereby enhancing security and ensuring control over data protection."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace
# custom:
#   id: CB_TFAZR_197
#   severity: HIGH
package lib.terraform.CB_TFAZR_197

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
	block.Type == "customer_managed_key"
	block.Attributes.key_vault_key_id != ""
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Service Bus utilizes customer-managed keys for data encryption, ensuring data security and control.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Service Bus must be configured to use customer-managed keys for data encryption to enhance security and maintain control over data protection.",
		"snippet": block, 
    }
}
