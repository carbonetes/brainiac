package lib.terraform.CB_TFAZR_084

test_cosmosdb_accounts_cmk_encrypted_at_rest {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_cosmosdb_account",
			"db",
		],
		"Attributes": {"key_vault_key_id": "carbo.id"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cosmosdb_accounts_not_cmk_encrypted_at_rest {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_cosmosdb_account",
			"db",
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
