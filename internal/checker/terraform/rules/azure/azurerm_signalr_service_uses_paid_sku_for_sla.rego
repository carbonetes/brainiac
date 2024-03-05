# METADATA
# title: "Use a Paid Sku for SignalR SLA"
# description: "This policy mandates the use of a paid SKU for Azure SignalR Service to ensure that SLA (Service Level Agreement) commitments are met."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/signalr_service
# custom:
#   id: CB_TFAZR_192
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_192

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_signalr_service" in block.Labels
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
    block.Type == "sku"
	block.Attributes.name != "Free_F1"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure SignalR Service uses a paid SKU, ensuring SLA commitments are met.",
		"snippet": block 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure SignalR Service should use a paid SKU to guarantee SLA commitments are met.",
		"snippet": block 
    }
}
