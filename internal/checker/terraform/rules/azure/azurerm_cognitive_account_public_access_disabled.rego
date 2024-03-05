# METADATA
# title: "Verify that Cognitive Services accounts have public network access deactivated"
# description: "Verify that Cognitive Services accounts have public network access disabled for enhanced security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account
# custom:
#   id: CB_TFAZR_130
#   severity: LOW
package lib.terraform.CB_TFAZR_130

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_cognitive_account" in block.Labels
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
		"message": "Cognitive Services accounts have public network access deactivated.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Cognitive Services accounts have public network access activated, it must be deactivated.",
		"snippet": block,
	}
}
