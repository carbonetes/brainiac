package lib.terraform.CB_TFAZR_017

test_azurerm_mssql_server_security_alert_policy_send_alerts_to_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mssql_server_security_alert_policy",
			"example",
		],
		"Attributes": {"email_addresses": ["example@gmail.com"]},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_mssql_server_security_alert_policy_send_alerts_to_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mssql_server_security_alert_policy",
			"example",
		],
		"Attributes": {},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
