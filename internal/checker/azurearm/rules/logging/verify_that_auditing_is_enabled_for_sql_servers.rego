# METADATA
# title: "Verify that Auditing is enabled for SQL servers"
# description: Verify that auditing functionality is activated for SQL servers to ensure comprehensive monitoring and compliance adherence.
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.sql/servers/databases?pivots=deployment-language-arm-template
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.sql/servers?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_023
#   severity: HIGH
package lib.azurearm.CB_AZR_023
import future.keywords.in

is_valid {
    supported_resources := ["Microsoft.Sql/servers/databases", "Microsoft.Sql/servers"]
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
    lower(properties.state) == "enabled"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
    some properties in pass
    result := { "message": "Auditing for SQL servers is enabled",
                "snippet": properties }
}

failed[result] {
    some properties in fail
    result := { "message": "Auditing for SQL servers is not enabled",
                "snippet": properties }
}
