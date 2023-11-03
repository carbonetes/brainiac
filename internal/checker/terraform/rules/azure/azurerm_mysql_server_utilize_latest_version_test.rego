package lib.terraform.CB_TFAZR_037

test_azurerm_mysql_server_utilize_latest_version_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mysql_server",
			"default",
		],
		"Attributes": {"ssl_minimal_tls_version_enforced": "TLS1_2"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_mysql_server_utilize_latest_version_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_mysql_server",
			"default",
		],
		"Attributes": {"ssl_minimal_tls_version_enforced": ""},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
