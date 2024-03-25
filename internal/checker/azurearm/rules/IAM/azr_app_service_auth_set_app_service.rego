# METADATA
# title: "Verify Azure App Service has App Service Authentication configured"
# description: "This policy ensures that App Service Authentication prenvents anonymous HTTP requests and enhancing security by requiring token-based authentication for users accessing the API app."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.web/sites/config-web?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_013
#   severity: MEDIUM
package lib.azurearm.CB_AZR_013

import future.keywords.in

is_valid {
	supported_resources := ["Microsoft.Web/sites/config", "config"]
	some resource in input.resources
	resource.type in supported_resources
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
	properties := resource.properties
	properties.enabled == true
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "App Service Authentication is configured on Azure App Service.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "App Service Authentication is not configured on Azure App Service.",
		"snippet": block,
	}
}
