# METADATA
# title: "Verify 'Send Alerts To' feature is activated for MSSQL servers"
# description: "This policy requires specifying an email address for receiving alerts when anomalous activities are detected on SQL servers. Adding this email address ensures prompt reporting of anomalies, facilitating early risk mitigation. We recommend including an email address in the 'Send Alerts To' field for MSSQL servers."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.sql/servers/databases?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_026
#   severity: HIGH
package lib.azurearm.CB_AZR_026
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
    properties.emailAddresses != ""
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some properties in pass
	result := { "message": "Send Alert to is enabled.",
                "snippet": properties }
}

failed[result] {
    some properties in fail
	result := { "message": "Send Alert to shoud be enabled.",
                "snippet": properties }
} 
