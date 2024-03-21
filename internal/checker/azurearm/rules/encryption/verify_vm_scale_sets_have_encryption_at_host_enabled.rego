# METADATA
# title: "Verify VM Scale Sets have encryption-at-host enabled"
# description: "This policy ensures that Virtual Machine Scale Sets are configured with encryption-at-host enabled, bolstering security measures within the system."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.compute/virtualmachinescalesets?pivots=deployment-language-arm-template
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.compute/virtualmachines?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_058
#   severity: LOW
package lib.azurearm.CB_AZR_058
import future.keywords.in

is_valid {
	supported_resources := ["Microsoft.Compute/virtualMachineScaleSets", "Microsoft.Compute/virtualMachines"]
	some resource in input.resources
	resource.type in supported_resources
}

resource[type] {
	some resource in input.resources
	is_valid
	count(fail) > 0
	type := resource.type
}

resource[type] {
	some resource in input.resources
	is_valid
	count(pass) > 0
	type := resource.type
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties.securityProfile
    lower(properties.encryptionAtHost) == "true"
}

pass[properties] {
     is_valid
     some resource in input.resources
     properties := resource.properties.virtualMachineProfile.securityProfile
     lower(properties.encryptionAtHost) == "true"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "VM scale sets encryption at host enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "VM scale sets encryption at host disabled",
		"snippet": block,
	}
}
