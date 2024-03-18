# METADATA
# title: "Verify that the Threat Detection types setting is configured to All"
# description: "Confirm that all available threat detection types are selected within the system settings to ensure comprehensive security coverage and protection against potential threats."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.sql/servers/databases?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_025
#   severity: HIGH
package lib.azurearm.CB_AZR_025
import future.keywords.in

resource := "Microsoft.Sql/servers/databases"

is_valid{
	some res in input.resources
    res.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties
    properties.state == "Enabled"
    properties.disabledAlerts == []
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
    some properties in pass
    result := { "message": "Threat Detection types setting is configured to All",
                "snippet": properties }
}

failed[result] {
    some properties in fail
    result := { "message": "Threat Detection types setting is not configured to All",
                "snippet": properties }
}
