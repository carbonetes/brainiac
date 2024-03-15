# METADATA
# title: "Require Double Encryption for Azure Service Bus"
# description: "This policy ensures that Azure Service Bus employs double encryption, enhancing data security and protection during communication."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace
# custom:
#   id: CB_TFAZR_195
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_195

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
	block.Attributes.infrastructure_encryption_enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Service Bus utilizes double encryption for enhanced data security.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Service Bus should implement double encryption to improve data security during communication.",
		"snippet": block, 
    }
}
