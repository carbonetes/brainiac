# METADATA
# title: "Validate the setup of the chosen destination for Azure SQL server ADS VA scan reports"
# description: "Confirm that the Azure SQL server's Vulnerability Assessment (VA) is set to send scan reports to the designated destination."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_security_alert_policy
# custom:
#   id: CB_TFAZR_215
#   severity: LOW
package lib.terraform.CB_TFAZR_215

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_mssql_server_security_alert_policy" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_sql_server[label] {
	some block in input
	block.Type == "resource"
	"azurerm_sql_server" in block.Labels
	label := concat(".", block.Labels)
}

label_for_mssql_server[label] {
	some block in input
	block.Type == "resource"
	"azurerm_mssql_server_security_alert_policy" in block.Labels
	label := concat(".", block.Labels)
}

sql_server_is_attached {
	some block in input
	block.Type == "resource"
	"azurerm_mssql_server_security_alert_policy" in block.Labels
	block.Attributes.state == "Enabled"
	some label in label_for_sql_server
	contains(block.Attributes.server_name, label)
}

mssql_server_is_attached {
	some block in input
	block.Type == "resource"
	"azurerm_mssql_server_vulnerability_assessment" in block.Labels
	some label in label_for_mssql_server
	contains(block.Attributes.server_security_alert_policy_id, label)
	some inner_block in block.Blocks
	inner_block.Type == "recurring_scans"
	inner_block.Attributes.email_subscription_admins == true
	"emails" in object.keys(inner_block.Attributes)
}

pass[block] {
	some block in input
	isvalid(block)
	sql_server_is_attached
	mssql_server_is_attached
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The chosen destination for Azure SQL server ADS VA scan reports is set.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The chosen destination for Azure SQL server ADS VA scan reports is not set.",
		"snippet": block,
	}
}
