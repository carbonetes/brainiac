# METADATA
# title: "Verify expiration date are set for all secrets"
# description: "This policy recommends setting explicit expiration times for all secrets stored in the Azure Key Vault (AKV). By default, secrets in AKV remain valid indefinitely, but setting expiration times ensures that they cannot be used beyond their designated lifetimes."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults/secrets?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_041
#   severity: CRITICAL
package lib.azurearm.CB_AZR_041
import future.keywords.in

resource := "Microsoft.KeyVault/vaults/secrets"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
 	is_valid
	some resource in input.resources
   	"properties" in object.keys(resource)
    properties := resource.properties
    "attributes" in object.keys(properties)
    attribute := properties.attributes
    "exp" in object.keys(attribute)
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Expiration date is set on all secrets",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Expiration date is not set on all secrets",
		"snippet": block,
	}
}