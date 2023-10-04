# METADATA
# title: "Verify Cosmos DB accounts have restricted access"
# description: "Verifying restricted access for Cosmos DB accounts enhances data security, compliance, and privacy by protecting sensitive data from unauthorized access, ensuring compliance with regulations, and reducing the risk of data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account
# custom:
#   id: CB_TFAZR_083
#   severity: LOW
package lib.terraform.CB_TFAZR_083

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_cosmosdb_account" in block.Labels
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

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Cosmos DB accounts have restricted access.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Cosmos DB accounts should have restricted access.",
		"snippet": block,
	}
}
