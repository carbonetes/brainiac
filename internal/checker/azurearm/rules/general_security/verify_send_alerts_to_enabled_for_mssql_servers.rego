# METADATA
# title: "Verify send alerts to enabled for MSSQL servers"
# description: "Verify that the 'Send Alerts To' option is enabled for Microsoft SQL (MSSQL) servers to ensure that alerts are appropriately routed and actioned."
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
