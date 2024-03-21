# METADATA
# title: "Verify server parameter 'connection_throttling' is enabled for PostgreSQL Database Server"
# description: "This policy recommends enabling connection_throttling for PostgreSQL Server Databases to adjust message verbosity regarding concurrent connections. This helps prevent potential Denial of Service (DoS) attacks and system overload issues, while facilitating identification and resolution of configuration errors and performance issues."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.dbforpostgresql/servers/configurations
# custom:
#   id: CB_AZR_032
#   severity: MEDIUM
package lib.azurearm.CB_AZR_032

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
	resource.name == "connection_throttling"
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
		"message": "PostgreSQL Database server has connection_throttling set to 'ON'.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "PostgreSQL Database server does not have connection_throttling set to 'ON'.",
		"snippet": block,
	}
}
