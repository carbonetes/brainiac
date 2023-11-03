package lib.terraform.CB_TFAZR_100

test_azurerm_mysql_server_threat_detection_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mysql_server",
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

test_azurerm_mysql_server_threat_detection_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mysql_server",
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
