package lib.terraform.CB_TFAZR_078

test_mysql_server_enabled_infra_encryption {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mysql_server",
			"example",
		],
		"Attributes": {"infrastructure_encryption_enabled": true},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_mysql_server_not_enabled_infra_encryption {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mysql_server",
			"example",
		],
		"Attributes": {"infrastructure_encryption_enabled": false},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
