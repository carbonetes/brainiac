# METADATA
# title: "Verify that Azure Cognitive Search has public network access disabled"
# description: "Ensure that Azure Cognitive Search restricts public network access to enhance security"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/search_service
# custom:
#   id: CB_TFAZR_127
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_127

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_search_service" in block.Labels
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
		"message": "Azure Cognitive Search has public network access disabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Cognitive Search does not have public network access disabled.",
		"snippet": block,
	}
}
