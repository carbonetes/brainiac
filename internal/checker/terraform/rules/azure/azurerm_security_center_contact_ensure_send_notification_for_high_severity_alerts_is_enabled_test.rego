package lib.terraform.CB_TFAZR_002

test_azurerm_security_center_contact_ensure_send_notification_for_high_severity_alerts_is_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_security_center_contact",
			"example",
		],
		"Attributes": {"alert_notifications": true},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_security_center_contact_ensure_send_notification_for_high_severity_alerts_is_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_security_center_contact",
			"example",
		],
		"Attributes": {"notalert_notifications": false},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
