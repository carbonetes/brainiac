# METADATA
# title: "Verify Web App redirects all HTTP traffic to HTTPS in Azure App Service"
# description: "This policy ensures that Azure Web Apps permit sites to operate under both HTTP and HTTPS, making them accessible to anyone using insecure HTTP links."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.web/sites?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_014
#   severity: MEDIUM
package lib.azurearm.CB_AZR_014

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
	properties.httpsOnly == true
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Web App redirects all HTTP traffic to HTTPS in Azure App Service.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Web App does not redirect all HTTP traffic to HTTPS in Azure App Service.",
		"snippet": block,
	}
}
