# METADATA
# title: "Confirm that the 'local_infile' flag for the MySQL database is configured to 'off'"
# description: "Verify that the 'local_infile' flag in the MySQL database configuration is set to 'off' to assure a higher level of security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
# custom:
#   id: CB_TFGCP_028
#   severity: LOW
package lib.terraform.CB_TFGCP_028

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
	db_flags_block.Attributes.name == "local_infile"
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
		"message": "The 'local_infile' flag in the MySQL database configuration is set to 'off'.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The 'local_infile' flag in the MySQL database configuration is set to 'on'.",
		"snippet": block,
	}
}
