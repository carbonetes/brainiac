package lib.terraform.CB_TFAZR_018

test_azurerm_monitor_log_profile_activity_log_retention_set_365 {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_monitor_log_profile",
			"example",
		],
		"Attributes": {
			"categories": [
				"Action",
				"Delete",
				"Write",
			],
			"locations": [
				"westus",
				"global",
			],
			"name": "default",
		},
		"Blocks": [{
			"Type": "retention_policy",
			"Labels": [],
			"Attributes": {
				"days": "365",
				"enabled": true,
			},
			"Blocks": [],
			"line_range": {
				"endLine": 15,
				"startLine": 12,
			},
		}],
		"line_range": {
			"endLine": 16,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_monitor_log_profile_activity_log_retention_not_set_365 {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_monitor_log_profile",
			"example",
		],
		"Attributes": {
			"categories": [
				"Action",
				"Delete",
				"Write",
			],
			"locations": [
				"westus",
				"global",
			],
			"name": "default",
		},
		"Blocks": [{
			"Type": "retention_policy",
			"Labels": [],
			"Attributes": {
				"days": "364",
				"enabled": true,
			},
			"Blocks": [],
			"line_range": {
				"endLine": 15,
				"startLine": 12,
			},
		}],
		"line_range": {
			"endLine": 16,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
