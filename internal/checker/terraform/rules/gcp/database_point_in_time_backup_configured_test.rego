package lib.terraform.CB_TFGCP_124

test_database_point_in_time_backup_configured {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"test",
		],
		"Attributes": {
			"database_version": "MYSQL_5_7",
			"name": "carbo_sql",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {"tier": "db-f1-micro"},
			"Blocks": [{
				"Type": "backup_configuration",
				"Labels": [],
				"Attributes": {"binary_log_enabled": "true"},
				"Blocks": [],
				"line_range": {
					"endLine": 9,
					"startLine": 7,
				},
			}],
			"line_range": {
				"endLine": 10,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_database_point_in_time_backup_not_configured {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"test",
		],
		"Attributes": {
			"database_version": "MYSQL_5_7",
			"name": "carbo_sql",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {"tier": "db-f1-micro"},
			"Blocks": [{
				"Type": "backup_configuration",
				"Labels": [],
				"Attributes": {"binary_log_enabled": "false"},
				"Blocks": [],
				"line_range": {
					"endLine": 9,
					"startLine": 7,
				},
			}],
			"line_range": {
				"endLine": 10,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
