# METADATA
# title: "Verify 'Email service and co-administrators' is activated for MSSQL servers"
# description: "This policy enables Service and Co-administrators to receive security alerts from the SQL server. Providing an email address for alert reception ensures swift reporting of any detected anomalous activities, enabling early mitigation of potential risks."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.sql/servers/databases?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_027
#   severity: MEDIUM
package lib.azurearm.CB_AZR_027
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
    lower(properties.emailAccountAdmins) == "enabled"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some properties in pass
	result := { "message": "Email Service and Co-administrators are enabled.",
                "snippet": properties }
}

failed[result] {
    some properties in fail
	result := { "message": "Email Service and Co-administrators are disabled.",
                "snippet": properties }
} 