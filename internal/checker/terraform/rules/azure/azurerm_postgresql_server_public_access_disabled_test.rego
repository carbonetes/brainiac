package lib.terraform.CB_TFAZR_088

test_azurerm_postgresql_server_public_access_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_postgresql_server",
			"example",
		],
		"Attributes": {"public_network_access_enabled": false},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_postgresql_server_public_access_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_postgresql_server",
			"example",
		],
		"Attributes": {"public_network_access_enabled": true},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
