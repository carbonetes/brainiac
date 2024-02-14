# METADATA
# title: "Verify Azure Cognitive Search Index Query SLA"
# description: "This policy checks whether an Azure Cognitive Search service maintains the required Service Level Agreement (SLA) for index queries. Azure Cognitive Search services are expected to provide reliable and efficient search capabilities, and ensuring they meet SLAs is crucial for performance and reliability."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/search_service
# custom:
#   id: CB_TFAZR_206
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_206

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
	to_number(resource.Attributes.replica_count) >= 2
}

pass[resource] {
	some resource in input
	isvalid(resource)
	is_number(resource.Attributes.replica_count)
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Azure Cognitive Search service maintains the required SLA for index queries, ensuring reliable and efficient search capabilities.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "The Azure Cognitive Search service does not meet the required SLA for index queries, which may result in performance and reliability issues.",
		"snippet": block, 
    }
}
