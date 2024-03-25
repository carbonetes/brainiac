# METADATA
# title: "Verify 'Public access level' is configured as Private for blob containers."
# description: "This policy enables anonymous, public read access to both a container and its blobs within Azure Blob storage. It allows read-only access to these resources without the need for sharing the account key or requiring a shared access signature."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts/blobservices/containers/immutabilitypolicies?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_034
#   severity: CRITICAL
package lib.azurearm.CB_AZR_034

import future.keywords.in

is_valid {
	supported_resources := ["Microsoft.Storage/storageAccounts/blobServices/containers", "blobServices/containers", "containers"]
	some resource in input.resources
	resource.type in supported_resources
}

resource[type] {
	some resource in input.resources
	is_valid
	count(fail) > 0
	type := resource.type
}

resource[type] {
	some resource in input.resources
	is_valid
	count(pass) > 0
	type := resource.type
}

fail[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties
	lower(properties.publicAccess) == "container"
}

fail[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties
	lower(properties.publicAccess) == "blob"
}

pass[resources] {
	resources := input.resources
	is_valid
	count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Public access level is set to Private for blob containers.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Public access level is not set to Private for blob containers.",
		"snippet": block,
	}
}
