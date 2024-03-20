# METADATA
# title: "Verify key vault is supported by HSM"
# description: "This policy ensures heightened security by enabling the use of hardware security modules (HSM) within Azure Key Vault, a practice referred to as Bring Your Own Key (BYOK). Keys remain within the HSM boundary for added assurance. Azure Key Vault utilizes nCipher nShield HSMs, validated at FIPS 140-2 Level 2, to protect keys. Consider the cost implications and alignment with your security posture when implementing this policy."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults/keys?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_065
#   severity: MEDIUM
package lib.azurearm.CB_AZR_065
import future.keywords.in

resource := "Microsoft.KeyVault/vaults/keys"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties
    "kty" in object.keys(properties)
    kty_values := ["RSA-HSM", "EC-HSM"]
    kty := properties.kty
    kty in kty_values
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Key vault key is backed by HSM",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Key vault key is not backed by HSM",
		"snippet": block,
	}
}