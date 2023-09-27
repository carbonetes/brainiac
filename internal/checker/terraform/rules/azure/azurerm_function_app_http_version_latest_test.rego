package lib.terraform.CB_TFAZR_070

test_azurerm_function_app_http_version_latest_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_function_app",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "site_config",
			"Labels": [],
			"Attributes": {"http2_enabled": true},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_function_app_http_version_latest_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_function_app",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "site_config",
			"Labels": [],
			"Attributes": {"http2_enabled": false},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
