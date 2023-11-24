package lib.terraform.CB_TFGCP_044

test_google_sql_database_instance_log_temp_files_set_zero_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"default",
		],
		"Attributes": {
			"database_version": "POSTGRES_11",
			"name": "master-instance",
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
					"name": "log_temp_files",
					"value": "0",
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

test_google_sql_database_instance_log_temp_files_set_zero_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"default",
		],
		"Attributes": {
			"database_version": "POSTGRES_11",
			"name": "master-instance",
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
					"name": "log_temp_files",
					"value": "1",
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
