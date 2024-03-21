# METADATA
# title: "Verify public network access is disabled for Azure Cosmos DB"
# description: "This policy ensures Azure Cosmos DB is kept private to prevent unauthorized access or tampering. Public access exposes it to internet-based threats like hackers or malware, whereas keeping it private restricts access to authorized users only."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.documentdb/databaseaccounts?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_060
#   severity: LOW
package lib.azurearm.CB_AZR_060
import future.keywords.in

resource := "Microsoft.DocumentDB/databaseAccounts"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties
    properties.publicNetworkAccess == "Disabled"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Cosmos DB public network access disabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Cosmos DB public network access enabled.",
		"snippet": block,
	}
}
