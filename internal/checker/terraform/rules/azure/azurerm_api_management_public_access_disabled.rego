# METADATA
# title: "Disable public access for API management"
# description: "Ensure that API management is configured to disable public access to enhance security and restrict access to authorized users only"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management
# custom:
#   id: CB_TFAZR_144
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_144

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_api_management" in block.Labels
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
		"message": "API management has public access disabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "API management should disable public access for enhanced security.",
		"snippet": block,
	}
}
