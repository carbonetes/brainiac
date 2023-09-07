package lib.terraform.CB_TFAZR_007

test_azurerm_mysql_server_ssl_connection_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mysql_server",
			"example",
		],
		"Attributes": {"ssl_enforcement_enabled": true},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_mysql_server_ssl_connection_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mysql_server",
			"example",
		],
		"Attributes": {"ssl_enforcement_enabled": false},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
