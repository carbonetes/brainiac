# METADATA
# title: "Verify Automatic OS Patching for VM Scale Sets"
# description: "This policy requires enabling automatic OS image patching on Virtual Machine Scale Sets to consistently maintain the security of Virtual Machines. It ensures the timely application of the latest security patches every month to keep the system secure."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.compute/virtualmachinescalesets?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_056
#   severity: LOW
package lib.azurearm.CB_AZR_056
import future.keywords.in

resource := "Microsoft.Compute/virtualMachineScaleSets"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[extension_properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties
	properties.orchestrationMode != "Flexible"
	extension_profile := properties.virtualMachineProfile.extensionProfile
	some extension in extension_profile.extensions
	extension_properties := extension.properties
	extension_properties.enableAutomaticUpgrade == true
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Automatic OS patching is enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Automatic OS patching is disabled",
		"snippet": block,
	}
}
