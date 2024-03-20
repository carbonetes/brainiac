# METADATA
# title: "Verify that key vault has soft delete enabled"
# description: "This policy ensures that deleting a key vault without soft delete enabled permanently erases all stored secrets, keys, and certificates. It prevents accidental data loss by allowing recovery of a deleted key vault within a configurable retention period."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_064
#   severity: MEDIUM
package lib.azurearm.CB_AZR_064
import future.keywords.in

resource := "Microsoft.KeyVault/vaults"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties
    "enableSoftDelete" in object.keys(properties)
    enable := properties.enableSoftDelete
    enable == true
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Key vault enables soft delete",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Key vault soft delete is not enabled",
		"snippet": block,
	}
}