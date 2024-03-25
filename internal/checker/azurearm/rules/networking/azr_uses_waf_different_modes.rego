# METADATA
# title: "Verify Azure Front Door utilizes WAF in various modes"
# description: "This policy has two modes: Detection and Prevention. In Detection mode, it analyzes incoming traffic, logging suspicious requests for potential security threats. In Prevention mode, it blocks malicious requests, preventing harm to the application."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.network/frontdoorwebapplicationfirewallpolicies?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_069
#   severity: LOW
package lib.azurearm.CB_AZR_069
import future.keywords.in

resource := "Microsoft.Network/FrontDoorWebApplicationFirewallPolicies"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
	is_valid
	some resource in input.resources
    properties := resource.properties
    "policySettings" in object.keys(properties)
    policy := properties.policySettings
    "enabledState" in object.keys(policy)
    state := policy.enabledState
    state == "Enabled"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Front Door uses WAF in different modes",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Front Door not using WAF in different modes",
		"snippet": block,
	}
}