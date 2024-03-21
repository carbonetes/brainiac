# METADATA
# title: "Verify Internet Access Restricted in HTTP port 80"
# description: "Ensure that internet access is restricted on port 80 (HTTP) within the network security configuration."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.network/networksecuritygroups?pivots=deployment-language-arm-template
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.network/networksecuritygroups/securityrules?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_076
#   severity: LOW
package lib.azurearm.CB_AZR_076
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
    is_valid
	some resource in input.resources
    properties := resource.properties.securityRules
    some security in properties
    security.access == "Deny"
	some port in properties
	port.destinationPortRange == "*"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some properties in pass
	result := { "message": "Internet access in HTTP port 80 restricted.",
                "snippet": properties }
}

failed[result] {
    some properties in fail
	result := { "message": "Internet access in HTTP port 80 is not restricted.",
                "snippet": properties }
} 

