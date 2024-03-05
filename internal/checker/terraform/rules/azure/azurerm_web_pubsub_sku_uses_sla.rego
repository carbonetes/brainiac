# METADATA
# title: "Require Web PubSub to use a SKU that includes an SLA"
# description: "This policy ensures that Web PubSub utilizes a Service Level Agreement (SLA)-backed SKU to guarantee reliability and performance for your application's real-time messaging requirements"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_pubsub
# custom:
#   id: CB_TFAZR_145
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_145

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
	resource.Attributes.sku != "Free_F1"
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
