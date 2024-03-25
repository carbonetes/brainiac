# METADATA
# title: "Verify all keys have an expiration date set"
# description: "This policy allows users to store and utilize cryptographic keys within the Microsoft Azure environment. The exp (expiration time) attribute specifies the time after which the key should not be used for cryptographic operations. By default, keys are not configured to expire."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults/keys?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_040
#   severity: CRITICAL
package lib.azurearm.CB_AZR_040

import future.keywords.in

resource := "Microsoft.KeyVault/vaults/keys"

is_valid {
	some resources in input.resources
	resources.type == resource
}

fail[properties] {
	some resource in input.resources
	properties := resource.properties.rotationPolicy.attributes
	properties.expiryTime == ""
}

pass[resources] {
	resources := input.resources
	is_valid
	count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Expiration date is set on all keys.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Expiration date is not set on all keys.",
		"snippet": block,
	}
}
