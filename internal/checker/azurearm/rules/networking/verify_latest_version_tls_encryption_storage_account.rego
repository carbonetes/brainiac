# METADATA
# title: "Verify latest version TLS encryption used in Storage Account"
# description: "This policy ensures that the latest version of TLS encryption protocol is employed within the configuration of a Storage Account in Azure."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.security/securitycontacts?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_078
#   severity: MEDIUM
package lib.azurearm.CB_AZR_078
import future.keywords.in

resource := "Microsoft.Storage/storageAccounts"

is_valid{
	some res in input.resources
    res.type == resource
}

pass[properties]{
    is_valid
	some resource in input.resources
    properties := resource.properties
    properties.minimumTlsVersion == "TLS1_2"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some properties in pass
	result := { "message": "Encryption Storage use latest version of TLS encryption.",
                "snippet": properties }
}

failed[result] {
    some properties in fail
	result := { "message": "Encryption Storage must use latest version of TLS encryption.",
                "snippet": properties }
} 

