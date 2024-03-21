# METADATA
# title: "Verify log_checkpoints Parameter is ON for PostgreSQL Server"
# description: "This policy suggests enabling log_checkpoints for PostgreSQL Server Databases to log each checkpoint and generate query and error logs. These logs help identify, troubleshoot, and resolve configuration errors and performance issues."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.dbforpostgresql/servers/configurations?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_030
#   severity: MEDIUM
package lib.azurearm.CB_AZR_030
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

pass[properties]{
    is_valid
	some resource in input.resources
    name := resource.name
    name == "log_checkpoints"
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
		"message": "Log_checkpoints is ON.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Log_checkpoints should be ON.",
		"snippet": block,
	}
}
