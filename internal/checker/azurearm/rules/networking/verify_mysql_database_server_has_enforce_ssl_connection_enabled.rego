# METADATA
# title: "Verify that the MySQL Database Server has Enforce SSL connection set to ENABLED"
# description: "Ensure that the MySQL database server enforces SSL connections by verifying that the Enforce SSL connection setting is set to ENABLED."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.dbformysql/servers?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_028
#   severity: MEDIUM
package lib.azurearm.CB_AZR_028
import future.keywords.in

resource := "Microsoft.DBforMySQL/servers"

is_valid{
	some res in input.resources
    res.type == resource
}

pass[properties]{
    is_valid
	some resource in input.resources
    properties := resource.properties
    properties.sslEnforcement == "Enabled"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some properties in pass
	result := { "message": "MySQL Database server SSL connection enabled.",
                "snippet": properties }
}

failed[result] {
    some properties in fail
	result := { "message": "MySQL Database server SSL connection disabled.",
                "snippet": properties }
} 

