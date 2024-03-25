# METADATA
# title: "Verify access for SSH is restricted from the internet"
# description: "This policy advises against enabling SSH access over the internet due to security risks. Attackers could use brute force techniques to compromise Azure Virtual Machines, potentially using them as launch points for further attacks within the Azure Virtual Network or targeting external devices. We recommend disabling SSH access over the internet through Network Security Groups."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.network/networksecuritygroups?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_010
#   severity: HIGH
package lib.azurearm.CB_AZR_010
import future.keywords.in

is_valid {
	supported_resources := ["Microsoft.Network/networkSecurityGroups", "Microsoft.Network/networkSecurityGroups/securityRules"]
	some resources in input.resources
	resources.type in supported_resources
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
    some resource in input.resources
    properties := resource.properties
    some security in properties.securityRules
    portrange := security.properties
    portrange.destinationPortRange == "22"
}

pass[properties] {
    some resource in input.resources
    properties := resource.properties
	properties.destinationPortRange == "22"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "SSH access is restricted from the internet",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "SSH access is not restricted from the internet",
		"snippet": block,
	}
}
