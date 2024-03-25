# METADATA
# title: "Verify Web App utilizes the most recent version of TLS encryption"
# description: "This policy ensures that the Transport Layer Security (TLS) protocol secures transmission of data over the internet using standard encryption technology."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.web/sites?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_015
#   severity: MEDIUM
package lib.azurearm.CB_AZR_015

import future.keywords.in

resource := "Microsoft.Web/sites"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties
	config := properties.siteConfig
	config.minTlsVersion == "1.2"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Web App is using the latest version of TLS encryption.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Web App is not using the latest version of TLS encryption.",
		"snippet": block,
	}
}
