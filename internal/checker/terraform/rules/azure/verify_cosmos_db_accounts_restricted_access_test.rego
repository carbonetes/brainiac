package lib.terraform.CB_TFAZR_083

test_cosmosdb_accounts_restricted_access {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_cosmosdb_account",
			"db",
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

test_azr_container_group_not_deployed_into_vnetwork {
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
