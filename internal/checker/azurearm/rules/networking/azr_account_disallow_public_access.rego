# METADATA
# title: "Verify public access for Storage accounts is not allowed"
# description: "This policy advises against granting anonymous or public access to storage accounts unless there is a compelling justification. Enabling access from all networks includes the internet."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_047
#   severity: LOW
package lib.azurearm.CB_AZR_047
import future.keywords.in

resource := "Microsoft.Storage/storageAccounts"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties
    "publicNetworkAccess" in object.keys(properties)
	properties.publicNetworkAccess != "Enabled"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Storage accounts disallow public access",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Storage accounts allowing public access",
		"snippet": block,
	}
}