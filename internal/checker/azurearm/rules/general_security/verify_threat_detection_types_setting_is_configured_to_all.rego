# METADATA
# title: "Verify Threat Detection types setting is configured to All"
# description: "This policy suggests that activating all Threat Detection Types safeguards against SQL injection, database vulnerabilities, and any other unusual activities. We advise enabling all types of threat detection on SQL servers."
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
    lower(properties.state) == "enabled"
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
