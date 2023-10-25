# METADATA
# title: "Guarantee the activation of Vulnerability Assessment (VA) for a SQL server through the configuration of a Storage Account"
# description: "Activate Vulnerability Assessment (VA) on a SQL server by configuring a Storage Account for enhanced security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_security_alert_policy
# custom:
#   id: CB_TFAZR_213
#   severity: LOW
package lib.terraform.CB_TFAZR_213

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

getLabelForSqlServer[label] {
	some block in input
	block.Type == "resource"
	"azurerm_sql_server" in block.Labels
	label := concat(".", block.Labels)
}

sql_server_is_attached {
	some block in input
	block.Type == "resource"
	"azurerm_mssql_server_security_alert_policy" in block.Labels
	some label in getLabelForSqlServer
	contains(block.Attributes.server_name, label)
}

pass[block] {
	some block in input
	isvalid(block)
	sql_server_is_attached
	block.Attributes.state == "Enabled"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Vulnerability Assessment (VA) on a SQL server by configuring a Storage Account for enhanced security is activated.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Vulnerability Assessment (VA) on a SQL server by configuring a Storage Account for enhanced security is not activated.",
		"snippet": block,
	}
}
