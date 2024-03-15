# METADATA
# title: "Verify that public network access is disabled for Azure Cosmos DB"
# description: "Check and ensure that Azure Cosmos DB has been configured to disable public network access. This security measure restricts access to the database from the public internet, enhancing data security"
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account
# custom:
#   id: CB_TFAZR_089
#   severity: LOW
package lib.terraform.CB_TFAZR_089


import future.keywords.in

supportedResources := [
	"azurerm_cosmosdb_account"
] 

isvalid(block) {
	block.Type == "resource"
	some label in block.Labels
	label in supportedResources
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
        "message": "Public network access is verified to be disabled for Azure Cosmos DB.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Public network access is not disabled for Azure Cosmos DB.",
		"snippet": block,
    }
}
