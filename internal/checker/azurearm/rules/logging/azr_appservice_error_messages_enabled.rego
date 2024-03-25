# METADATA
# title: "Verify detailed error messages for App Service is enabled"
# description: "This policy provides enhanced information regarding an error within your application, including the error code, the exact line of code where the error occurred, and a comprehensive description of the error. Such details are instrumental in diagnosing issues within your application and determining the root cause of the problem."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.web/sites/config-web?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_049
#   severity: LOW
package lib.azurearm.CB_AZR_049
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
    "detailedErrorLoggingEnabled" in object.keys(properties)
	properties.detailedErrorLoggingEnabled == true
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "App service enables detailed error messages",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "App service not enables detailed error message",
		"snippet": block,
	}
}