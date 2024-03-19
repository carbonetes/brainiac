# METADATA
# title: "Verify that standard pricing tier is selected"
# description: "This policy ensures the selection of the standard pricing tier, which enhances defense-in-depth strategies and strengthens overall security posture by enabling comprehensive threat detection capabilities for networks and virtual machines through features such as threat intelligence, anomaly detection, and behavior analytics provided by the Microsoft Security Response Center (MSRC) within the Azure Security Center."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.security/pricings?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_019
#   severity: MEDIUM
package lib.azurearm.CB_AZR_019

import future.keywords.in

resource := "Microsoft.Security/pricings"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties
	lower(properties.pricingTier) == "standard"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Standard pricing tier is selected.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Standard pricing tier is not selected.",
		"snippet": block,
	}
}
