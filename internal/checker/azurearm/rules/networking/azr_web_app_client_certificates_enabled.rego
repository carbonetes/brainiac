# METADATA
# title: "Verify Web App has Incoming client certificates configured"
# description: "This policy ensures the usage of client certificates for incoming requests on the Web App, thereby ensuring that only clients with valid certificates can access the application."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.web/sites?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_017
#   severity: MEDIUM
package lib.azurearm.CB_AZR_017

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
	lower(properties.clientCertEnabled) == "true"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
    some block in pass
    result := {
        "message": "Web App has 'Client Certificates (Incoming client certificates)' enabled.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Web App does not have 'Client Certificates (Incoming client certificates)' enabled.",
        "snippet": block,
    }
}
