package lib.terraform.CB_TFAZR_129

test_azurerm_cosmosdb_account_privileged_escalation_denied {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_cosmosdb_account",
			"db",
		],
		"Attributes": {
			"access_key_metadata_writes_enabled": false,
			"name": "db",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_azurerm_cosmosdb_account_privileged_escalation_allowed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_cosmosdb_account",
			"db",
		],
		"Attributes": {
			"access_key_metadata_writes_enabled": true,
			"name": "db",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
