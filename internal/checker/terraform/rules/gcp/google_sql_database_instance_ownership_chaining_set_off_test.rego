package lib.terraform.CB_TFGCP_052

test_google_sql_database_instance_ownership_chaining_set_off_passed {
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
				"Type": "database_flags",
				"Labels": [],
				"Attributes": {
					"name": "cross db ownership chaining",
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

test_google_sql_database_instance_ownership_chaining_set_off_failed {
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
				"Type": "database_flags",
				"Labels": [],
				"Attributes": {
					"name": "cross db ownership chaining",
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
