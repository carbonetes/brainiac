package lib.terraform.CB_TFAZR_216

test_azurerm_mssql_server_email_notif_set_passed {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"azurerm_sql_server",
				"okExample",
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
				"okExample",
			],
			"Attributes": {
				"resource_group_name": "azurerm_resource_group.okExample.name",
				"server_name": "azurerm_sql_server.okExample.name",
				"state": "Enabled",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 14,
				"startLine": 10,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"azurerm_mssql_server_vulnerability_assessment",
				"okExample",
			],
			"Attributes": {
				"server_security_alert_policy_id": "azurerm_mssql_server_security_alert_policy.okExample.id",
				"storage_account_access_key": "azurerm_storage_account.okExample.primary_access_key",
				"storage_container_path": "azurerm_storage_account.okExample.primary_blob_endpoint",
			},
			"Blocks": [{
				"Type": "recurring_scans",
				"Labels": [],
				"Attributes": {
					"email_subscription_admins": true,
					"emails": [
						"email@example1.com",
						"email@example2.com",
					],
					"enabled": true,
				},
				"Blocks": [],
				"line_range": {
					"endLine": 28,
					"startLine": 21,
				},
			}],
			"line_range": {
				"endLine": 29,
				"startLine": 16,
			},
		},
	]
	count(result) == 1
}

test_azurerm_mssql_server_email_notif_set_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"azurerm_sql_server",
				"okExample",
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
				"okExample",
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
		{
			"Type": "resource",
			"Labels": [
				"azurerm_mssql_server_vulnerability_assessment",
				"okExample",
			],
			"Attributes": {
				"storage_account_access_key": "azurerm_storage_account.okExample.primary_access_key",
				"storage_container_path": "azurerm_storage_account.okExample.primary_blob_endpoint",
			},
			"Blocks": [{
				"Type": "recurring_scans",
				"Labels": [],
				"Attributes": {
					"email_subscription_admins": false,
					"enabled": true,
				},
				"Blocks": [],
				"line_range": {
					"endLine": 28,
					"startLine": 21,
				},
			}],
			"line_range": {
				"endLine": 29,
				"startLine": 16,
			},
		},
	]
	count(result) == 1
}
