# METADATA
# title: "Verify that Cognitive Services accounts have public network access disabled"
# description: "This policy ensures that by disabling the public network access property, security is enhanced, restricting access to Cognitive Services solely from private endpoints. This configuration effectively blocks access from any public address space outside of the Azure IP range and denies logins that match IP or virtual network-based firewall rules."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.cognitiveservices/accounts?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_073
#   severity:  LOW
package lib.azurearm.CB_AZR_073

import future.keywords.in

resource := "Microsoft.CognitiveServices/accounts"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
	some resource in input.resources
	properties := resource.properties
	properties.publicNetworkAccess == "Disabled"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
    some block in pass
    result := {
        "message": "Cognitive Services accounts are disabled for public network access.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Cognitive Services accounts are not disabled for public network access.",
        "snippet": block,
    }
}
