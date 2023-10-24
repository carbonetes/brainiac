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

isvalid(block){
	block.Type == "resource"
    "azurerm_mssql_server_security_alert_policy" in block.Labels
}

has_attribute(key, value){
    _ = key[value]
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}


getLabelForSqlServer[label]{
	some block in input
    block.Type == "resource"
    "azurerm_sql_server" in block.Labels
    label := concat(".", block.Labels)
}
getLabelForMssqlServer[label]{
	some block in input
    block.Type == "resource"
    "azurerm_mssql_server_security_alert_policy" in block.Labels
    label := concat(".", block.Labels)
}

sqlServerIsAttached{
    some block in input
    block.Type == "resource"
    "azurerm_mssql_server_security_alert_policy" in block.Labels
    block.Attributes.state == "Enabled"
    contains(block.Attributes.server_name, getLabelForSqlServer[label])
}

mssqlServerIsAttached{
    some block in input
    block.Type == "resource"
    "azurerm_mssql_server_vulnerability_assessment" in block.Labels
    contains(block.Attributes.server_security_alert_policy_id, getLabelForMssqlServer[label])
    some innerBlock in block.Blocks
    innerBlock.Type == "recurring_scans"
    innerBlock.Attributes.email_subscription_admins == true
    has_attribute(innerBlock.Attributes, "emails")
}

pass[block]{
    some block in input
	isvalid(block)
    sqlServerIsAttached
    mssqlServerIsAttached
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { "message": "The chosen destination for Azure SQL server ADS VA scan reports is set.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "The chosen destination for Azure SQL server ADS VA scan reports is not set.",
                "snippet": block }
} 