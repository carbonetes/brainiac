package lib.terraform.CB_TFGCP_065

test_google_sql_database_instance_gcp_postgresql_logs_sql_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"example",
		],
		"Attributes": {
			"database_version": "POSTGRES_11",
			"name": "example-instance",
			"region": "us-central1",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "database_flags",
				"Labels": [],
				"Attributes": {
					"name": "log_statement",
					"value": "all",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 10,
					"startLine": 7,
				},
			}],
			"line_range": {
				"endLine": 11,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_google_sql_database_instance_gcp_postgresql_logs_sql_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"example",
		],
		"Attributes": {
			"database_version": "POSTGRES_11",
			"name": "example-instance",
			"region": "us-central1",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "database_flags",
				"Labels": [],
				"Attributes": {
					"name": "log_statement",
					"value": "",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 10,
					"startLine": 7,
				},
			}],
			"line_range": {
				"endLine": 11,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
