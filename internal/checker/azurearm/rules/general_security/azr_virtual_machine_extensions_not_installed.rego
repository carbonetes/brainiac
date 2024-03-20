# METADATA
# title: "Verify extensions for Virtual Machine are not installed"
# description: "This policy ensures Azure virtual machines (VMs) do not have extensions installed, adhering to security and compliance standards. VM extensions, small cloud applications for post-deployment tasks, operate with administrative privileges and could access sensitive data."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.compute/virtualmachines?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_045
#   severity: MEDIUM
package lib.azurearm.CB_AZR_045
import future.keywords.in

resource := "Microsoft.Compute/virtualMachines"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
 	is_valid
	some resource in input.resources
  	properties := resource.properties
    os := properties.osProfile
    os.allowExtensionOperations == false
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Virtual Machine Extensions are not Installed",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Virtual Machine Extensions must not be Installed",
		"snippet": block,
	}
}