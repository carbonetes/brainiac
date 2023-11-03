package lib.terraform.CB_TFAZR_043

test_azurerm_function_app_authentication_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_function_app",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "auth_settings",
			"Labels": [],
			"Attributes": {"enabled": true},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_function_app_authentication_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_function_app",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "auth_settings",
			"Labels": [],
			"Attributes": {"enabled": false},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
