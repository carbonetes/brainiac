# METADATA
# title: "Verify Automatic OS Patching for VM Scale Sets"
# description: "Ensure that automatic operating system patching is enabled and functional for Virtual Machine Scale Sets to maintain security and reliability."
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

pass[properties] {
 	is_valid
	some resource in input.resources
  	properties := resource.properties
    properties.enableAutomaticUpgrade == true
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