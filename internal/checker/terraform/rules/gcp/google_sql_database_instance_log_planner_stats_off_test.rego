package lib.terraform.CB_TFGCP_130

test_google_sql_database_instance_log_planner_stats_off {
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
					"name": "log_planner_stats",
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

test_google_sql_database_instance_log_planner_stats_on {
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
					"name": "log_planner_stats",
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
