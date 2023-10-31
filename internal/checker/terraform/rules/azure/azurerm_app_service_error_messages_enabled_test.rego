package lib.terraform.CB_TFAZR_067

test_azurerm_app_service_error_messages_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_app_service",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "logs",
			"Labels": [],
			"Attributes": {"detailed_error_messages_enabled": true},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_app_service_error_messages_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_app_service",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "logs",
			"Labels": [],
			"Attributes": {"detailed_error_messages_enabled": false},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
