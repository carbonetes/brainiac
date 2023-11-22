package lib.terraform.CB_TFGCP_123

test_google_sql_database_instance_postgresql_log_duration_on {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"example",
		],
		"Attributes": {
			"database_version": "MYSQL",
			"name": "your-instance-name",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "database_flags",
				"Labels": [],
				"Attributes": {
					"name": "log_duration",
					"value": "on",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 9,
					"startLine": 6,
				},
			}],
			"line_range": {
				"endLine": 10,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_google_sql_database_instance_postgresql_log_duration_off {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"example",
		],
		"Attributes": {
			"database_version": "POSTGRES",
			"name": "your-instance-name",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "database_flags",
				"Labels": [],
				"Attributes": {
					"name": "log_duration",
					"value": "off",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 9,
					"startLine": 6,
				},
			}],
			"line_range": {
				"endLine": 10,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
