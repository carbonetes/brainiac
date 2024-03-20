# METADATA
# title: "Verify API management services utilizes virtual networks"
# description: "This policy ensures that your API management service operates within a dedicated virtual network, enabling you to regulate inbound and outbound network traffic using network security groups (NSGs) and service endpoints. This enhances security by protecting against unauthorized access and potential attacks."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.apimanagement/service?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_062
#   severity: LOW
package lib.azurearm.CB_AZR_062
import future.keywords.in

resource := "Microsoft.ApiManagement/service"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties
    "virtualNetworkConfiguration" in object.keys(properties)
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "API management services uses virtual networks",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "API management services is not using virtual networks",
		"snippet": block,
	}
}