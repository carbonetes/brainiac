package lib.terraform.CB_TFAZR_095

test_azurerm_function_app_https_accessible_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_app_service",
			"example",
		],
		"Attributes": {"https_only": true},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_function_app_https_accessible_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_app_service",
			"example",
		],
		"Attributes": {"https_only": false},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
