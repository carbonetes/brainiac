# METADATA
# title: "Verify server parameter 'log_retention' is set to 'ON' for PostgreSQL Database Server"
# description: "This policy is designed to enhance the data retention and auditability of PostgreSQL Database Servers by verifying that the 'log_retention' parameter is set to 'ON'."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_configuration
# custom:
#   id: CB_TFAZR_116
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_116

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_postgresql_configuration" in block.Labels
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
	block.Attributes.name == "log_retention"
	block.Attributes.value == "on"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The 'log_retention' parameter is set to 'ON' for PostgreSQL Database Server.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The 'log_retention' parameter is set to 'OFF' for PostgreSQL Database Server.",
		"snippet": block,
	}
}