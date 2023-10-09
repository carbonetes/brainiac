package lib.terraform.CB_TFAZR_151

test_azurerm_cosmosdb_account_local_auth_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_cosmosdb_account",
			"pass",
		],
		"Attributes": {
			"enable_free_tier": true,
			"kind": "GlobalDocumentDB",
			"local_authentication_disabled": true,
			"location": "uksouth",
			"name": "pike-sql",
			"offer_type": "Standard",
			"resource_group_name": "pike",
		},
		"Blocks": [{
			"Type": "consistency_policy",
			"Labels": [],
			"Attributes": {
				"consistency_level": "Session",
				"max_interval_in_seconds": "5",
				"max_staleness_prefix": "100",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 14,
				"startLine": 10,
			},
		}],
		"line_range": {
			"endLine": 15,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_azurerm_cosmosdb_account_local_auth_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_cosmosdb_account",
			"pass",
		],
		"Attributes": {
			"enable_free_tier": true,
			"kind": "GlobalDocumentDB",
			"local_authentication_disabled": false,
			"location": "uksouth",
			"name": "pike-sql",
			"offer_type": "Standard",
			"resource_group_name": "pike",
		},
		"Blocks": [{
			"Type": "consistency_policy",
			"Labels": [],
			"Attributes": {
				"consistency_level": "Session",
				"max_interval_in_seconds": "5",
				"max_staleness_prefix": "100",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 14,
				"startLine": 10,
			},
		}],
		"line_range": {
			"endLine": 15,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
