package lib.terraform.CB_TFAZR_030

test_azurerm_monitor_log_profile_audit_profile_captures_activities_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_monitor_log_profile",
			"example",
		],
		"Attributes": {"categories": [
			"Action",
			"Delete",
			"Write",
		]},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_monitor_log_profile_audit_profile_captures_activities_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_monitor_log_profile",
			"example",
		],
		"Attributes": {"categories": []},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
