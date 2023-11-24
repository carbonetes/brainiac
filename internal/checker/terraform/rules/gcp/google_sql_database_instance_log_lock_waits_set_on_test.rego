package lib.terraform.CB_TFGCP_042

test_google_sql_database_instance_log_lock_waits_set_on {
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
					"name": "log_lock_waits",
					"value": "on",
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

test_google_sql_database_instance_log_lock_waits_set_off {
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
					"name": "log_lock_waits",
					"value": "off",
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
