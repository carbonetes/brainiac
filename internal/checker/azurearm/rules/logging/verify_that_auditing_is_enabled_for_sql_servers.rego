# METADATA
# title: "Verify that Auditing is enabled for SQL servers"
# description: "This policy suggests activating auditing at the server level on the Azure platform for comprehensive tracking of database events, aiding in regulatory compliance, understanding database activity, and detecting anomalies that may indicate business concerns or potential security breaches."
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
