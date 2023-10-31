# METADATA
# title: "Verify default Auditing policy for a SQL Server is configured to capture and retain the activity logs"
# description: "This policy is designed to enhance the auditability and compliance of SQL Servers by verifying that the default auditing policy is configured to capture and retain activity logs."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database_extended_auditing_policy
# custom:
#   id: CB_TFAZR_170
#   severity: LOW
package lib.terraform.CB_TFAZR_170

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_mssql_database_extended_auditing_policy" in block.Labels
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
	block.Attributes.log_monitoring_enabled == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Default auditing policy for the SQL Server is configured to capture and retain activity logs.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Default auditing policy for the SQL Server is not configured to capture and retain activity logs.",
		"snippet": block,
	}
}