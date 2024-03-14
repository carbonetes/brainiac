# METADATA
# title: "Verify Azure Instance does not use basic authentication(Use SSH Key Instead)"
# description: "Ensuring Azure instances do not use basic authentication but rather SSH keys enhances security and simplifies authentication management."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.compute/virtualmachines?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_001
#   severity: HIGH
package lib.azurearm.CB_AZR_001
import future.keywords.in

resource := "Microsoft.Compute/virtualMachines"

is_valid{
	some res in input.resources
    res.type == resource
}

fail[properties]{
    is_valid
	some resource in input.resources
    properties := resource.properties
    config := properties.osProfile.linuxConfiguration
    config.disablePasswordAuthentication == false
}


pass[resources]{
	resources := input.resources
    is_valid
    count(fail) == 0
}

passed[result] {
	some block in pass
	result := { "message": "Azure Instance does not use basic authentication.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Azure Instance disablePasswordAuthentication should be set to true.",
                "snippet": block }
} 

