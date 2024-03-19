# METADATA
# title: "Verify HTTP logging for App Service is enabled"
# description: "This policy allows for the activation of HTTP logging within your app service. This feature facilitates the gathering of essential data, which can then be utilized for monitoring and diagnosing your application. Moreover, it aids in the detection of security vulnerabilities or risks, contributing to the overall smooth operation and security fortification of your application against potential threats or attacks."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.web/sites/config-web?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_048
#   severity: LOW
package lib.azurearm.CB_AZR_048
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
    "httpLoggingEnabled" in object.keys(properties)
	properties.httpLoggingEnabled == true
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "App service enables HTTP logging",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "App service not enables HTTP logging",
		"snippet": block,
	}
}