# METADATA
# title: "Azure Cognitive Search Service Managed Identity Requirement"
# description: "This policy mandates that Azure Cognitive Search service must utilize managed identities for accessing Azure resources, enhancing security and access management."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/search_service
# custom:
#   id: CB_TFAZR_204
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_204

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
	some block in resource.Blocks
	block.Type == "identity"
	block.Attributes.type == "SystemAssigned"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Cognitive Search service uses managed identities to access Azure resources, ensuring enhanced security and access management.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Cognitive Search service should be configured to use managed identities for accessing Azure resources to enhance security and access management.",
		"snippet": block, 
    }
}
