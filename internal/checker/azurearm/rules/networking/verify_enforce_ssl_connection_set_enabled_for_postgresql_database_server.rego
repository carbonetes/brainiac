# METADATA
# title: "Verify Enforce SSL connection is set to ENABLED for PostgreSQL Database Server"
# description: "Verify that the PostgreSQL database server has SSL connection enforcement enabled to enhance security and protect data transmissions."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.dbforpostgresql/servers/databases?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_029
#   severity: MEDIUM
package lib.azurearm.CB_AZR_029
import future.keywords.in

resource := "Microsoft.DBforPostgreSQL/servers/configurations"

is_valid {
	some resources in input.resources
	resources.type == resource
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
	some block in pass
	result := {
		"message": "SSL connection is set to enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "SSL connection is set to disabled.",
		"snippet": block,
	}
}
