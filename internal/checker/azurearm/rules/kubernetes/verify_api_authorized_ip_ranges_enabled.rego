# METADATA
# title: "Verify API server authorized IP ranges for AKS are enabled"
# description: "This policy ensures that the AKS API server, which manages cluster actions like resource creation and node scaling, is accessed only from specified IP address ranges. Unauthorized requests from outside these ranges are blocked, enhancing cluster security."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.containerservice/managedclusters?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_006
#   severity: LOW
package lib.azurearm.CB_AZR_006
import future.keywords.in

resource := "Microsoft.ContainerService/managedClusters"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
    some resource in input.resources
    properties := resource.properties
    api_value := ["2017-08-31", "2018-03-31"]
    apiversion := resource.apiVersion
    not apiversion in api_value
}

pass[properties] {
    some resource in input.resources
    properties := resource.properties
    api_support := ["2019-02-01", "2019-04-01", "2019-06-01"]
    apiversion := resource.apiVersion
    apiversion in api_support
    "apiServerAuthorizedIPRanges" in properties
}

pass[properties] {
    some resource in input.resources
    properties := resource.properties
    authorized := properties.apiServerAccessProfile
    "apiServerAccessProfile" in properties
    "authorizedIPRanges" in authorized
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "AKS has an API Server Authorized IP Ranges enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "AKS have no API Server Authorized IP Ranges enabled",
		"snippet": block,
	}
}
