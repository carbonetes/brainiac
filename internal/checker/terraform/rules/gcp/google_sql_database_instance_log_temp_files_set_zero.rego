# METADATA
# title: "Verify that the 'log_temp_files' configuration for the PostgreSQL database is configured with a value of '0' to ensure proper logging of temporary file operations"
# description: "Confirm that the 'log_temp_files' configuration for the PostgreSQL database is set to '0' to facilitate accurate logging of temporary file activities"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
# custom:
#   id: CB_TFGCP_044
#   severity: LOW
package lib.terraform.CB_TFGCP_044

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
	db_flags_block.Attributes.name == "log_temp_files"
	db_flags_block.Attributes.value == "0"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The 'log_temp_files' configuration for the PostgreSQL database is set to '0'.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The 'log_temp_files' configuration for the PostgreSQL database must be set to '0'.",
		"snippet": block,
	}
}
