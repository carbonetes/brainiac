package lib.terraform.CB_TFAZR_021

test_azurerm_sql_server_auditing_set_on {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"azurerm_sql_server",
				"example",
			],
			"Attributes": {},
			"Blocks": [{
				"Type": "extended_auditing_policy",
				"Labels": [],
				"Attributes": {
					"retention_in_days": "90",
					"storage_account_access_key": "azurerm_storage_account.example.primary_access_key",
					"storage_account_access_key_is_secondary": true,
					"storage_endpoint": "azurerm_storage_account.example.primary_blob_endpoint",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 7,
					"startLine": 2,
				},
			}],
			"line_range": {
				"endLine": 8,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"azurerm_mssql_server",
				"example",
			],
			"Attributes": {},
			"Blocks": [{
				"Type": "extended_auditing_policy",
				"Labels": [],
				"Attributes": {
					"retention_in_days": "90",
					"storage_account_access_key": "azurerm_storage_account.example.primary_access_key",
					"storage_account_access_key_is_secondary": true,
					"storage_endpoint": "azurerm_storage_account.example.primary_blob_endpoint",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 16,
					"startLine": 11,
				},
			}],
			"line_range": {
				"endLine": 17,
				"startLine": 10,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"azurerm_mssql_server_extended_auditing_policy",
				"example",
			],
			"Attributes": {"server_id": "azurerm_mssql_server.example.id"},
			"Blocks": [],
			"line_range": {
				"endLine": 23,
				"startLine": 19,
			},
		},
	]
	count(result) == 1
}

test_azurerm_sql_server_auditing_not_set {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"azurerm_sql_server",
				"example",
			],
			"Attributes": {},
			"Blocks": [{
				"Type": "extended_auditing_policy",
				"Labels": [],
				"Attributes": {
					"retention_in_days": "90",
					"storage_account_access_key": "azurerm_storage_account.example.primary_access_key",
					"storage_account_access_key_is_secondary": true,
					"storage_endpoint": "azurerm_storage_account.example.primary_blob_endpoint",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 7,
					"startLine": 2,
				},
			}],
			"line_range": {
				"endLine": 8,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"azurerm_mssql_server",
				"example",
			],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 17,
				"startLine": 10,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"azurerm_mssql_server_extended_auditing_policy",
				"example",
			],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 23,
				"startLine": 19,
			},
		},
	]
	count(result) == 1
}
