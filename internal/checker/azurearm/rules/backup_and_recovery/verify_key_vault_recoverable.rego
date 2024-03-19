# METADATA
# title: "Verify key vault is recoverable"
# description: "This policy recommends enabling the Do Not Purge and Soft Delete functions for the Key Vault. This prevents accidental or deliberate deletion, safeguarding against immediate data loss or security compromise. The Key Vault contains crucial objects like keys, secrets, and certificates, and its unavailability can disrupt authentication, validation, and other security functions. Deleting or purging the Key Vault would result in immediate data loss, including keys used for encrypting data in storage accounts and databases."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_042
#   severity: MEDIUM
package lib.azurearm.CB_AZR_042
import future.keywords.in

resource := "Microsoft.KeyVault/vaults"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
 	is_valid
	some resource in input.resources
   	"properties" in object.keys(resource)
    properties := resource.properties
    "enablePurgeProtection" in object.keys(properties)
    "enableSoftDelete" in object.keys(properties)
    lower(properties.enablePurgeProtection) == "true"
    lower(properties.enableSoftDelete) == "true"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Key vault is recoverable",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Key vault is not recoverable",
		"snippet": block,
	}
}