# METADATA
# title: "Verify that sql servers enables data security policy"
# description: "This policy is designed to enhance the security and data protection of SQL Servers by verifying that data security policies are enabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_security_alert_policy
# custom:
#   id: CB_TFAZR_218
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_218

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_sql_server" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

getTheLabelforSqlServer[label] {
	some resource in input
	resource.Type == "resource"
	"azurerm_sql_server" in resource.Labels
	label := concat(".", resource.Labels)
}

isServerSecurityAlertPolicyEnabled {
	some block in input
	block.Type == "resource"
	"azurerm_mssql_server_security_alert_policy" in block.Labels
	some label in getTheLabelforSqlServer
	contains(block.Attributes.server_name, label)
	block.Attributes.state == "Enabled"
}

pass[block] {
	some block in input
	isvalid(block)
	isServerSecurityAlertPolicyEnabled
}


fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "SQL servers enables data security policy.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "SQL servers does not enable data security policy.",
		"snippet": block,
	}
}
