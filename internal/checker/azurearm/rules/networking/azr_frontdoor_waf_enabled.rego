# METADATA
# title: "Verify WAF is enabled on Azure Front Door"
# description: "This policy, when enabled on Azure Front Door, protects web applications by scrutinizing incoming traffic and blocking malicious requests before they reach the application. It helps defend against threats like SQL injection, cross-site scripting (XSS), and other attacks."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.network/frontdoors?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_068
#   severity: MEDIUM
package lib.azurearm.CB_AZR_068
import future.keywords.in

resource := "Microsoft.Network/frontDoors"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
 	is_valid
	some resource in input.resources
    properties := resource.properties
    "frontendEndpoints" in object.keys(properties)
   	some frontend in properties.frontendEndpoints
    properties2 := frontend.properties
    "webApplicationFirewallPolicyLink" in object.keys(properties2)
    web_app := properties2.webApplicationFirewallPolicyLink
    "id" in object.keys(web_app)
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Front Door enables WAF",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Front Door does not enables WAF",
		"snippet": block,
	}
}