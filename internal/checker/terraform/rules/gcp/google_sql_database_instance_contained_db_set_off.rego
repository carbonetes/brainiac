# METADATA
# title: "Verify that the SQL database has the 'contained database authentication' setting configured to 'off'"
# description: "Confirm that the SQL database is configured with the 'contained database authentication' setting set to 'off' to strengthen security measures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
# custom:
#   id: CB_TFGCP_053
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_053

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

fail[block] {
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "settings"
	some db_flags_block in inner_block.Blocks
	db_flags_block.Type == "database_flags"
	db_flags_block.Attributes.name == "contained database authentication"
	db_flags_block.Attributes.value == "on"
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
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
