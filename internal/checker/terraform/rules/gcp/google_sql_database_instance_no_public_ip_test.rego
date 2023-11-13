package lib.terraform.CB_TFGCP_055

test_google_sql_database_instance_no_public_ip_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"default",
		],
		"Attributes": {
			"database_version": "SQLSERVER_2017_STANDARD",
			"name": "master-instance",
			"region": "us-central1",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "ip_configuration",
				"Labels": [],
				"Attributes": {"ipv4_enabled": "false"},
				"Blocks": [],
				"line_range": {
					"endLine": 9,
					"startLine": 7,
				},
			}],
			"line_range": {
				"endLine": 10,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_google_sql_database_instance_no_public_ip_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"default",
		],
		"Attributes": {
			"database_version": "SQLSERVER_2017_STANDARD",
			"name": "master-instance",
			"region": "us-central1",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "ip_configuration",
				"Labels": [],
				"Attributes": {"ipv4_enabled": "true"},
				"Blocks": [],
				"line_range": {
					"endLine": 9,
					"startLine": 7,
				},
			}],
			"line_range": {
				"endLine": 10,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
