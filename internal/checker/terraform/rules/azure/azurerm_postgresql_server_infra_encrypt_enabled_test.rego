package lib.terraform.CB_TFAZR_120

test_azurerm_postgresql_server_infra_encrypt_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_postgresql_server",
			"example",
		],
		"Attributes": {"infrastructure_encryption_enabled": true},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_postgresql_server_infra_encrypt_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_postgresql_server",
			"example",
		],
		"Attributes": {"infrastructure_encryption_enabled": false},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
