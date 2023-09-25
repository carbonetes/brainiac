package lib.terraform.CB_TFAZR_034

test_azurerm_mssql_server_mssql_utilize_latest_version_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mssql_server",
			"example",
		],
		"Attributes": {"minimum_tls_version": "1.2"},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_mssql_server_mssql_utilize_latest_version_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mssql_server",
			"example",
		],
		"Attributes": {"minimum_tls_version": "1.1"},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
