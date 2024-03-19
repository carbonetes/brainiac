# METADATA
# title: "Verify encryption for Azure manage disk is enabled"
# description: "This policy ensures data disk encryption in Azure. By default, it employs Server-Side Encryption (SSE) with platform-managed keys (SSE with PMK). However, it's recommended to opt for either SSE with Azure Disk Encryption (SSE with PMK+ADE) or Customer Managed Key (SSE with CMK) for enhanced security and compliance control. This encryption process incurs no additional cost and doesn't impact managed disk performance."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.compute/disks?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_002
#   severity: HIGH
package lib.azurearm.CB_AZR_002
import future.keywords.in

resource := "Microsoft.Compute/disks"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
     properties := resource.properties
    "encryption" in object.keys(properties)
}

pass[properties] {
	is_valid
	some resource in input.resources
    properties := resource.properties
   	encrypt := properties.encryptionSettingsCollection
   	lower(encrypt.enabled) == "true"
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties
    encrypt := properties.encryptionSettings
    lower(encrypt.enabled) == "true"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure managed disk have encryption enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure managed disk encryption is not enabled",
		"snippet": block,
	}
}
