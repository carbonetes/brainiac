# METADATA
# title: "Verify content type is configured for Key Vault secrets"
# description: "This policy ensures that Azure Key Vault, a service for securely managing secrets, incorporates a content type tag to classify secrets such as passwords, connection strings, etc. It helps to differentiate between various types of secrets, each potentially requiring different rotation protocols."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults/secrets?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_067
#   severity: LOW
package lib.azurearm.CB_AZR_067
import future.keywords.in

resource := "Microsoft.KeyVault/vaults/secrets"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties
    "contentType" in object.keys(properties)
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Key vault secrets have contentType set",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Key vault secrets not have contentType set",
		"snippet": block,
	}
}