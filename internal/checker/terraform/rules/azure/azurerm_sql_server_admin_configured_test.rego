package lib.terraform.CB_TFAZR_217

test_azurerm_sql_server_admin_configured_passed {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"azurerm_sql_server",
				"sql_server_good",
			],
			"Attributes": {
				"administrator_login": "4dm1n157r470r",
				"administrator_login_password": "4-v3ry-53cr37-p455w0rd",
				"location": "azurerm_resource_group.example.location",
				"name": "mysqlserver",
				"resource_group_name": "azurerm_resource_group.example.name",
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
				"azurerm_sql_active_directory_administrator",
				"example",
			],
			"Attributes": {
				"login": "sqladmin",
				"object_id": "data.azurerm_client_config.current.object_id",
				"resource_group_name": "azurerm_resource_group.example.name",
				"server_name": "azurerm_sql_server.sql_server_good.name",
				"tenant_id": "data.azurerm_client_config.current.tenant_id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 17,
				"startLine": 11,
			},
		},
	]
	count(result) == 1
}

test_azurerm_sql_server_admin_configured_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"azurerm_sql_server",
				"sql_server_good",
			],
			"Attributes": {
				"administrator_login": "4dm1n157r470r",
				"administrator_login_password": "4-v3ry-53cr37-p455w0rd",
				"location": "azurerm_resource_group.example.location",
				"name": "mysqlserver",
				"resource_group_name": "azurerm_resource_group.example.name",
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
				"azurerm_sql_active_directory_administrator",
				"example",
			],
			"Attributes": {
				"login": "sqladmin",
				"object_id": "data.azurerm_client_config.current.object_id",
				"resource_group_name": "azurerm_resource_group.example.name",
				"tenant_id": "data.azurerm_client_config.current.tenant_id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 17,
				"startLine": 11,
			},
		},
	]
	count(result) == 1
}
