package lib.terraform.CB_TFAZR_112

test_azurerm_postgresql_server_threat_detection_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_postgresql_server",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "threat_detection_policy",
			"Labels": [],
			"Attributes": {"enabled": true},
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

test_azurerm_postgresql_server_threat_detection_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_postgresql_server",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "threat_detection_policy",
			"Labels": [],
			"Attributes": {"enabled": false},
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
