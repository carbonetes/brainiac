package lib.terraform.CB_TFAZR_020

test_azurerm_mssql_server_auditing_retention_greater_than_90_passed {
	result := passed with input as [{
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
				"endLine": 7,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_mssql_server_auditing_retention_greater_than_90_failed {
	result := failed with input as [{
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
				"retention_in_days": "80",
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
	}]
	count(result) == 1
}
