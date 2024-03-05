# METADATA
# title: "Verify that Local Authentication is deactivated in CosmosDB"
# description: "Confirm that Local Authentication is deactivated in CosmosDB, enhancing security by preventing unauthorized access through this authentication method."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account
# custom:
#   id: CB_TFAZR_151
#   severity: LOW
package lib.terraform.CB_TFAZR_151

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
	resource.Attributes.local_authentication_disabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Local Authentication is deactivated in CosmosDB.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Local Authentication is activated in CosmosDB, it must be deactivated.",
		"snippet": block,
	}
}
