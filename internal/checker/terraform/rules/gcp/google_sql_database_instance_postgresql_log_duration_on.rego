# METADATA
# title: "Verify that the 'log_duration' flag in the PostgreSQL database is configured to 'on'"
# description: "Confirm that the configuration of the PostgreSQL database includes the 'log_duration' flag set to 'on,' ensuring optimal logging of query durations for monitoring and analysis purposes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
# custom:
#   id: CB_TFGCP_123
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_123

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

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.database_version != "POSTGRES"
}

pass[block] {
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "settings"
	some db_flags_block in inner_block.Blocks
	db_flags_block.Type == "database_flags"
	db_flags_block.Attributes.name == "log_duration"
	db_flags_block.Attributes.value == "on"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The 'log_duration' flag in the PostgreSQL database is configured to 'on'.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The 'log_duration' flag in the PostgreSQL database must be configured to 'on'.",
		"snippet": block,
	}
}
