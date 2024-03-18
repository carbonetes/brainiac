# METADATA
# title: "Verify that the Auditing Retention for SQL servers exceeds 90 days"
# description: "Verify that the duration set for retaining auditing logs on SQL servers surpasses the threshold of 90 days."
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
    properties := resource.properties.retentionDays
    properties >= 90
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
