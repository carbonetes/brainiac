# METADATA
# title: "Verify that Virtual Machine does not enable password authentication"
# description: "This policy emphasizes the importance of disabling password authentication on your Azure virtual machine (VM) to enhance its security. Password authentication allows users to access the VM using a password, rather than an Azure Active Directory (Azure AD) account or other authentication method."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.compute/virtualmachinescalesets?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_074
#   severity: LOW
package lib.azurearm.CB_AZR_074

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
	properties := resource.properties.virtualMachineProfile.osProfile.linuxConfiguration
	properties.disablePasswordAuthentication == true
}

pass[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties.virtualMachineProfile.osProfile.linuxConfiguration
	lower(properties.disablePasswordAuthentication) == "true"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
    some block in pass
    result := {
        "message": "Password authentication is disabled on the virtual machine.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Password authentication is not disabled on the virtual machine.",
        "snippet": block,
    }
}
