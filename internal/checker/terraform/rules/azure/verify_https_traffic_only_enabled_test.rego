package lib.terraform.CB_TFAZR_047

test_https_traffic_only_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_storage_account",
			"storage_account",
		],
		"Attributes": {"enable_https_traffic_only": true},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_https_traffic_only_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_storage_account",
			"storage_account",
		],
		"Attributes": {"enable_https_traffic_only": false},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
