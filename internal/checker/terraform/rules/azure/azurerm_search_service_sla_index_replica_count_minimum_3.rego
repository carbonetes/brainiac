# METADATA
# title: "Azure Cognitive Search Index Update SLA Compliance"
# description: "This policy ensures that Azure Cognitive Search maintains the specified Service Level Agreement (SLA) for index updates, ensuring reliable performance and responsiveness."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/search_service
# custom:
#   id: CB_TFAZR_205
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_205

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
	to_number(resource.Attributes.replica_count) >= 3
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
		"message": "Azure Cognitive Search successfully maintains the SLA for index updates, providing reliable performance and responsiveness.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Cognitive Search fails to maintain the specified SLA for index updates, potentially leading to performance and responsiveness issues.",
		"snippet": block, 
    }
}
