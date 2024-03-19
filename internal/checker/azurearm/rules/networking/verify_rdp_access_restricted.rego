# METADATA
# title: "Verify access for RDP is restricted from the internet"
# description: "This policy addresses the security concern of potential brute force attacks via RDP over the internet, which could lead to unauthorized access to Azure Virtual Machines. Attackers may leverage compromised machines to launch further attacks within the Azure Virtual Network or target external devices. To mitigate this risk, we recommend disabling RDP access over the internet in Network Security Groups."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.network/networksecuritygroups?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_009
#   severity: HIGH
package lib.azurearm.CB_AZR_009
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
    portrange.destinationPortRange == "3389"
}

pass[properties] {
    some resource in input.resources
    properties := resource.properties
	properties.destinationPortRange == "3389"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "RDP access is restricted from the internet",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "RDP access is not restricted from the internet",
		"snippet": block,
	}
}
