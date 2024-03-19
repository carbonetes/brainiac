# METADATA
# title: "Verify HTTPS only allowed if supportsHttpsTrafficOnly is true"
# description: "This policy recommends enforcing secure transfer for all storage accounts, ensuring that Azure Storage REST API operations are exclusively conducted over HTTPS. It also advises configuring Azure Blob storage to accept requests only from secure connections by enabling the Secure Transfer Required property. This ensures that any requests originating from insecure connections are rejected."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts?pivots=deployment-language-arm-templatee
# custom:
#   id: CB_AZR_003
#   severity: HIGH
package lib.azurearm.CB_AZR_003
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
	lower(properties.supportsHttpsTrafficOnly) == "true"
}

pass[properties] {
 	is_valid
	some resource in input.resources
    properties := resource.properties
    not "supportsHttpsTrafficOnly" in object.keys(properties)
    apiversion := resource.apiVersion
    apiversion >= "2019"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "supportsHttpsTrafficOnly is set to true",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "supportsHttpsTrafficOnly is set to false",
		"snippet": block,
	}
}