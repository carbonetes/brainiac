# METADATA
# title: "Verify Cosmos DB uses customer-managed keys for data encryption"
# description: "Ensure that Cosmos DB utilizes customer-managed keys for encrypting data, enhancing security measures for data at rest."
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
