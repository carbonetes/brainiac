# METADATA
# title: "Verify that the Email service and co-administrators are enabled for MSSQL servers"
# description: "Ensure that the email service and co-administrators are properly enabled and functioning on MSSQL servers by conducting thorough verification checks."
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