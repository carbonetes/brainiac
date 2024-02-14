# METADATA
# title: "Enforce the utilization of managed identities by Web PubSub for Azure resource access"
# description: "This check ensures that Web PubSub services use managed identities to securely access Azure resources"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_pubsub
# custom:
#   id: CB_TFAZR_146
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_146

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_web_pubsub" in block.Labels
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
    some innerblock in resource.Blocks
	innerblock.Type == "identity"
	innerblock.Attributes.type != null
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Web PubSub is configured to use a SKU that includes an SLA.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Web PubSub should use a SKU that includes an SLA for enhanced reliability and performance.",
		"snippet": block,
	}
}
