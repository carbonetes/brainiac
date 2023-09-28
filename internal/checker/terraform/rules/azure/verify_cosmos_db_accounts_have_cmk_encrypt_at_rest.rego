# METADATA
# title: "Verify that Cosmos DB accounts have customer-managed keys to encrypt data at rest"
# description: "This practice ensures that sensitive data stored in Cosmos DB is protected through encryption using keys controlled by the customer, enhancing data confidentiality and meeting regulatory requirements."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account
# custom:
#   id: CB_TFAZR_084
#   severity: LOW
package lib.terraform.CB_TFAZR_084

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
	resource.Attributes.key_vault_key_id != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Cosmos DB accounts have customer-managed keys to encrypt data at rest.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Cosmos DB accounts should have customer-managed keys to encrypt data at rest.",
		"snippet": block,
	}
}
