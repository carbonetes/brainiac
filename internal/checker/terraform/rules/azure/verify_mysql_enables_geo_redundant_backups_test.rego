package lib.terraform.CB_TFAZR_073

test_mysql_geo_redundant_backup {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mysql_server",
			"test",
		],
		"Attributes": {"geo_redundant_backup_enabled": true},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_mysql_geo_redundant_backup_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mysql_server",
			"test",
		],
		"Attributes": {"geo_redundant_backup_enabled": false},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
