package lib.terraform.CB_TFAZR_028

test_azurerm_storage_account_trusted_microsoft_services_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_storage_account",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "network_rules",
			"Labels": [],
			"Attributes": {
				"bypass": ["AzureServices"],
				"default_action": "Allow",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_storage_account_trusted_microsoft_services_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_storage_account",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "network_rules",
			"Labels": [],
			"Attributes": {
				"bypass": ["SomeValue"],
				"default_action": "Deny",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
