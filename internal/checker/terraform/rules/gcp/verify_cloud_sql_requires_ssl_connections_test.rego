package lib.terraform.CB_TFGCP_010

test_cloud_sql_required_ssl_connection {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"main",
		],
		"Attributes": {
			"database_version": "POSTGRES_14",
			"name": "main-instance",
			"region": "us-central1",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {"tier": "db-f1-micro"},
			"Blocks": [{
				"Type": "ip_configuration",
				"Labels": [],
				"Attributes": {"require_ssl": true},
				"Blocks": [],
				"line_range": {
					"endLine": 10,
					"startLine": 8,
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

test_cloud_sql_not_required_ssl_connection {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"main",
		],
		"Attributes": {
			"database_version": "POSTGRES_14",
			"name": "main-instance",
			"region": "us-central1",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {"tier": "db-f1-micro"},
			"Blocks": [{
				"Type": "ip_configuration",
				"Labels": [],
				"Attributes": {"require_ssl": false},
				"Blocks": [],
				"line_range": {
					"endLine": 10,
					"startLine": 8,
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
