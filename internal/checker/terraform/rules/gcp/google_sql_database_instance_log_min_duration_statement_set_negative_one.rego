# METADATA
# title: "Verify that the 'log_min_duration_statement' configuration for the PostgreSQL database is configured to '-1'"
# description: "Confirm that the 'log_min_duration_statement' parameter for the PostgreSQL database is appropriately configured to '-1', effectively disabling logging for statements based on their execution duration"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
# custom:
#   id: CB_TFGCP_048
#   severity: LOW
package lib.terraform.CB_TFGCP_048

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
	some inner_block in block.Blocks
	inner_block.Type == "settings"
	some db_flags_block in inner_block.Blocks
	db_flags_block.Type == "database_flags"
	db_flags_block.Attributes.name == "log_min_duration_statement"
	db_flags_block.Attributes.value == "-1"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The 'log_min_duration_statement' configuration for the PostgreSQL database is configured to '-1'.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The 'log_min_duration_statement' configuration for the PostgreSQL database is not configured to '-1'.",
		"snippet": block,
	}
}
