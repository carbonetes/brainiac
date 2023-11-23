package lib.terraform.CB_TFGCP_129

test_google_sql_database_instance_log_parser_stats_set_off {
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
					"name": "log_parser_stats",
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

test_google_sql_database_instance_log_parser_stats_set_on {
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
					"name": "log_parser_stats",
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
