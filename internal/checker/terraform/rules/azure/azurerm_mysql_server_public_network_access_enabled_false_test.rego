package lib.terraform.CB_TFAZR_036

test_azurerm_mysql_server_public_network_access_enabled_false {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mysql_server",
			"example",
		],
		"Attributes": {"public_network_access_enabled": false},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_mysql_server_public_network_access_enabled_true {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mysql_server",
			"example",
		],
		"Attributes": {"public_network_access_enabled": true},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
