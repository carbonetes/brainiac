# METADATA
# title: "Verify that Google Cloud Platform's PostgreSQL records SQL statements for logging purposes"
# description: "Confirm that the Google Cloud Platform's PostgreSQL database instance is configured to log SQL statements for comprehensive logging."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
# custom:
#   id: CB_TFGCP_065
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_065

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
	expected_values := ["ddl", "mod", "all"]
	some inner_block in block.Blocks
	inner_block.Type == "settings"
	some db_flags_block in inner_block.Blocks
	db_flags_block.Type == "database_flags"
	db_flags_block.Attributes.name == "log_statement"
	db_flags_block.Attributes.value in expected_values
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Google Cloud Platform's PostgreSQL database instance is configured to log SQL statements.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Google Cloud Platform's PostgreSQL database instance is not configured to log SQL statements.",
		"snippet": block,
	}
}
