package lib.terraform.CB_TFAZR_114

test_azurerm_mariadb_server_geo_backups_activated {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mariadb_server",
			"example",
		],
		"Attributes": {"geo_redundant_backup_enabled": true},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_mariadb_server_geo_backups_not_activated {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mariadb_server",
			"example",
		],
		"Attributes": {"geo_redundant_backup_enabled": false},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
