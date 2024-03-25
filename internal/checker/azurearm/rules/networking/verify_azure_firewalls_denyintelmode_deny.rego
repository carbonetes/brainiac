# METADATA
# title: "Verify Azure Firewalls DenyIntelMode set to Deny"
# description: "This policy checks if 'DenyIntelMode' is set to 'Deny' for Azure Firewalls, crucial for network security. 'DenyIntelMode' filters network traffic based on threat intelligence rules; failure to set it to 'Deny' exposes systems to security risks like data breaches and DDoS attacks, contravening best practices."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.network/azurefirewalls?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_077
#   severity: HIGH
package lib.azurearm.CB_AZR_077
import future.keywords.in

resource := "Microsoft.Network/azureFirewalls"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties
	properties.threatIntelMode == "Deny"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "DenyIntelMode set to Deny.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "DenyIntelMode set must be Deny.",
		"snippet": block,
	}
}
