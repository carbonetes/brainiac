package lib.terraform.CB_TFGCP_027

test_cloudsql_backup_config_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"main",
		],
		"Attributes": {
			"database_version": "POSTGRES_14",
			"name": "main-instance",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "backup_configuration",
				"Labels": [],
				"Attributes": {"enabled": true},
				"Blocks": [],
				"line_range": {
					"endLine": 8,
					"startLine": 6,
				},
			}],
			"line_range": {
				"endLine": 9,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloudsql_backup_config_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"main",
		],
		"Attributes": {
			"database_version": "POSTGRES_14",
			"name": "main-instance",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "backup_configuration",
				"Labels": [],
				"Attributes": {"enabled": false},
				"Blocks": [],
				"line_range": {
					"endLine": 8,
					"startLine": 6,
				},
			}],
			"line_range": {
				"endLine": 9,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
