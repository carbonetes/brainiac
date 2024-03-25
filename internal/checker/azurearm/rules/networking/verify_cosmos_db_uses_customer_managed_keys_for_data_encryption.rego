# METADATA
# title: "Verify Cosmos DB uses customer-managed keys for data encryption"
# description: "This policy ensures data encryption in Azure Cosmos accounts, utilizing either service-managed keys or customer-managed keys (CMKs). CMKs offer users full control over encryption keys stored in Azure Key Vault, providing an additional layer of encryption on top of the default encryption with service-managed keys."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.documentdb/databaseaccounts?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_059
#   severity: LOW
package lib.azurearm.CB_AZR_059
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
    properties.keyVaultKeyUri != ""
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Cosmos DB customer manager key enabled at rest.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Cosmos DB customer manager key should be enabled at rest.",
		"snippet": block,
	}
}
