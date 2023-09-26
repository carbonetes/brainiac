package lib.terraform.CB_TFAZR_057

test_azurerm_storage_account_disallow_public_access_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_storage_account",
			"pike",
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

test_azurerm_storage_account_disallow_public_access_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_storage_account",
			"pike",
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
