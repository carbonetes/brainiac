package lib.terraform.CB_TFAZR_006

test_azurerm_mssql_server_security_alert_policy_email_service_coadmin_enabled_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mssql_server_security_alert_policy",
			"example",
		],
		"Attributes": {"email_account_admins": true},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_mssql_server_security_alert_policy_email_service_coadmin_enabled_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mssql_server_security_alert_policy",
			"example",
		],
		"Attributes": {"email_account_admins": false},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
