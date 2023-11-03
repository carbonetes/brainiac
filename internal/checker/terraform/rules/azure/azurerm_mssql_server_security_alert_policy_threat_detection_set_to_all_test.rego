package lib.terraform.CB_TFAZR_026

test_azurerm_mssql_server_security_alert_policy_threat_detection_set_to_all {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mssql_server_security_alert_policy",
			"example",
		],
		"Attributes": {"disabled_alerts": []},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_mssql_server_security_alert_policy_threat_detection_not_set_to_all {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mssql_server_security_alert_policy",
			"example",
		],
		"Attributes": {"disabled_alerts": [
			"Sql_Injection_Anomaly",
			"Data_Exfiltration",
		]},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
