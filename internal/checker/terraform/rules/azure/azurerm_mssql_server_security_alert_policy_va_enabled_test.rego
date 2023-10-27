package lib.terraform.CB_TFAZR_213

test_azurerm_mssql_server_security_alert_policy_va_enabled {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"azurerm_sql_server",
				"test",
			],
			"Attributes": {
				"administrator_login": "4dm1n157r470r",
				"administrator_login_password": "4-v3ry-53cr37-p455w0rd",
				"location": "azurerm_resource_group.okExample.location",
				"name": "mysqlserver",
				"resource_group_name": "azurerm_resource_group.okExample.name",
				"version": "12.0",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"azurerm_mssql_server_security_alert_policy",
				"test",
			],
			"Attributes": {
				"resource_group_name": "azurerm_resource_group.okExample.name",
				"server_name": "azurerm_sql_server.test.name",
				"state": "Enabled",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 14,
				"startLine": 10,
			},
		},
	]
	count(result) == 1
}

test_azurerm_mssql_server_security_alert_policy_va_disabled {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"azurerm_sql_server",
				"test",
			],
			"Attributes": {
				"administrator_login": "4dm1n157r470r",
				"administrator_login_password": "4-v3ry-53cr37-p455w0rd",
				"location": "azurerm_resource_group.okExample.location",
				"name": "mysqlserver",
				"resource_group_name": "azurerm_resource_group.okExample.name",
				"version": "12.0",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"azurerm_mssql_server_security_alert_policy",
				"test",
			],
			"Attributes": {
				"resource_group_name": "azurerm_resource_group.okExample.name",
				"state": "Disabled",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 14,
				"startLine": 10,
			},
		},
	]
	count(result) == 1
}
