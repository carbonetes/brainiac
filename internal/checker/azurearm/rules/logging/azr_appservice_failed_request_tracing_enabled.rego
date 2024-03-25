# METADATA
# title: "Verify failed request tracing for App Service is enabled"
# description: "This policy allows for the activation of failed request tracing within your app service. It facilitates the gathering of relevant data, which can be instrumental in diagnosing app-related issues and pinpointing potential concerns. Consequently, this measure contributes to maintaining the operational efficiency of your app, ensuring its ability to effectively manage and resolve any encountered errors."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.web/sites/config-web?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_050
#   severity: LOW
package lib.azurearm.CB_AZR_050
import future.keywords.in

resource := "Microsoft.Web/sites/config"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties
    "requestTracingEnabled" in object.keys(properties)
	properties.requestTracingEnabled == true
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "App service enables failed request tracing",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "App service not enables failed request tracing",
		"snippet": block,
	}
}