# METADATA
# title: "Verify PostgreSQL Database Server configuration for 'log_connections' is enabled"
# description: "This policy ensures log_connections in a PostgreSQL Database allows logging attempted connections to the server alongside successful client authentication, providing valuable data for identifying and troubleshooting configuration errors, as well as pinpointing sub-optimal performance issues."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.dbforpostgresql/servers/configurations?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_031
#   severity: MEDIUM
package lib.azurearm.CB_AZR_031

import future.keywords.in

is_valid {
	supported_resources := ["Microsoft.DBforPostgreSQL/servers/configurations", "configurations"]
	some resource in input.resources
	resource.type in supported_resources
}

resource[type] {
	some resource in input.resources
	is_valid
	count(fail) > 0
	type := resource.type
}

resource[type] {
	some resource in input.resources
	is_valid
	count(pass) > 0
	type := resource.type
}

pass[properties] {
	is_valid
	some resource in input.resources
	resource.name == "log_connections"
	properties := resource.properties
	lower(properties.value) == "on"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "PostgreSQL Database Server configuration 'log_connections' is set to 'ON'.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "PostgreSQL Database Server configuration 'log_connections' is not set to 'ON'.",
		"snippet": block,
	}
}
