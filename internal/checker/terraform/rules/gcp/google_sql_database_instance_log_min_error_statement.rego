# METADATA
# title: "Verify GCP PostgreSQL Database Log Levels"
# description: "This policy ensures that log levels for Google Cloud Platform (GCP) PostgreSQL databases are set to ERROR or lower. Configuring log levels to a minimum of ERROR enhances security by focusing on critical issues."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
# custom:
#   id: CB_TFGCP_122
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_122

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_sql_database_instance" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
    flag_values = [
        "debug5",
        "debug4",
        "debug3",
        "debug2",
        "debug1",
        "info",
        "notice",
        "warning",
        "error",
    ]
	some resource in input
	isvalid(resource)
    some block in resource.Blocks
    block.Type == "settings"
    some innerblock in block.Blocks
    innerblock.Type == "database_flags"
	innerblock.Attributes.name == "log_min_error_statement"
    innerblock.Attributes.value in flag_values
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "GCP PostgreSQL database log levels are appropriately configured to ERROR or lower, enhancing security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "GCP PostgreSQL database log levels are set to a level higher than ERROR. Update the log level configuration to ERROR or lower for improved security.",
		"snippet": block,
	}
}
