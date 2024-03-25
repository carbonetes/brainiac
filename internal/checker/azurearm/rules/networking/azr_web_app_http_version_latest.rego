# METADATA
# title: "Verify Web App utilizes the latest version of the HTTP protocol"
# description: "This policy ensures that the web app utilizes the latest version of HTTP, HTTP/2.0, which offers enhanced performance improvements over previous versions, including mitigating the head-of-line blocking issue, header compression, and prioritization of requests."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.web/sites?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_018
#   severity: MEDIUM
package lib.azurearm.CB_AZR_018

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
	properties.http20Enabled == true
}

pass[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties
	lower(properties.http20Enabled) == "true"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Web App has 'HTTP Version' set to the latest version, HTTP/2.0.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Web App does not have 'HTTP Version' set to the latest version, HTTP/2.0.",
		"snippet": block,
	}
}
