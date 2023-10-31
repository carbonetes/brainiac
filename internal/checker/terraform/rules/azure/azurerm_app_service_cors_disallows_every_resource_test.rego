package lib.terraform.CB_TFAZR_049

test_azurerm_app_service_cors_disallows_every_resource_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_app_service",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "site_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "cors",
				"Labels": [],
				"Attributes": {"allowed_origins": ["192.0.0.1"]},
				"Blocks": [],
				"line_range": {
					"endLine": 6,
					"startLine": 4,
				},
			}],
			"line_range": {
				"endLine": 7,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_app_service_cors_disallows_every_resource_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_app_service",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "site_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "cors",
				"Labels": [],
				"Attributes": {"allowed_origins": ["*"]},
				"Blocks": [],
				"line_range": {
					"endLine": 6,
					"startLine": 4,
				},
			}],
			"line_range": {
				"endLine": 7,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
