# METADATA
# title: "Verify managed disks utilize specified encryption for customer-managed keys"
# description: "Verify that the managed disks within the system are configured to utilize specific encryption methodologies tailored for the encryption of data using customer-managed keys, ensuring robust security measures are in place."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.compute/disks?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_054
#   severity: LOW
package lib.azurearm.CB_AZR_054
import future.keywords.in

resource := "Microsoft.Compute/disks"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties.encryption
    properties.diskEncryptionSetId != ""
}


fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Managed disks utilize specified encryption",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Managed disks not utilize specified encryption",
		"snippet": block,
	}
}
