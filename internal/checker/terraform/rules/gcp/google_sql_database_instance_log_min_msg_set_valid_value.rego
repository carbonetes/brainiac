# METADATA
# title: "Confirm that the 'log_min_messages' configuration for the PostgreSQL database is established with an appropriate and valid value"
# description: "Validate that the 'log_min_messages' configuration for the PostgreSQL database is configured with a legitimate and accepted value for proper control of log messaging."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
# custom:
#   id: CB_TFGCP_043
#   severity: LOW
package lib.terraform.CB_TFGCP_043

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
	expected_value := [
		"DEBUG5",
		"DEBUG4",
		"DEBUG3",
		"DEBUG2",
		"DEBUG1",
		"INFO",
		"NOTICE",
		"WARNING",
		"ERROR",
		"LOG",
		"FATAL",
		"PANIC",
	]
	some inner_block in block.Blocks
	inner_block.Type == "settings"
	some db_flags_block in inner_block.Blocks
	db_flags_block.Type == "database_flags"
	db_flags_block.Attributes.name == "log_min_messages"
	db_flags_block.Attributes.value in expected_value
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The 'log_min_messages' configuration for the PostgreSQL database is configured with an accepted value.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The 'log_min_messages' configuration for the PostgreSQL database is not configured with an accepted value.",
		"snippet": block,
	}
}
