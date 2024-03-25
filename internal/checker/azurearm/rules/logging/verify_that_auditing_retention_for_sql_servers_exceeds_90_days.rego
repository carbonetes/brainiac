# METADATA
# title: "Verify that the Auditing Retention for SQL servers exceeds 90 days"
# description: "This policy advises utilizing Audit Logs for anomaly detection and insights into potential breaches or misuse of information and access. We recommend setting SQL server audit retention to over 90 days."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.sql/servers?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_024
#   severity: HIGH
package lib.azurearm.CB_AZR_024
import future.keywords.in

resource := "Microsoft.Sql/servers"

is_valid{
	some res in input.resources
    res.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties
    lower(properties.state) == "enabled"
    properties.retentionDays >= 90
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
    some properties in pass
    result := { "message": "Auditing retention exceeds 90 days",
                "snippet": properties }
}

failed[result] {
    some properties in fail
    result := { "message": "Auditing retention  does not exceed 90 days",
                "snippet": properties }
}
