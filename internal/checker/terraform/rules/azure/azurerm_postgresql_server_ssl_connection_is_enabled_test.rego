package lib.terraform.CB_TFAZR_009

test_azurerm_postgresql_server_ssl_connection_is_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_postgresql_server",
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

test_azurerm_postgresql_server_ssl_connection_is_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_postgresql_server",
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
