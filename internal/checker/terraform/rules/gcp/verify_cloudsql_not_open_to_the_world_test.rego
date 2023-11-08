package lib.terraform.CB_TFGCP_020

test_cloud_sql_not_publicly_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"postgres",
		],
		"Attributes": {
			"database_version": "POSTGRES_15",
			"name": "random_id.db_name_suffix.hex",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {"tier": "db-f1-micro"},
			"Blocks": [{
				"Type": "ip_configuration",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "dynamic",
					"Labels": ["authorized_networks"],
					"Attributes": {
						"for_each": "google_compute_instance.apps",
						"iterator": "apps",
					},
					"Blocks": [{
						"Type": "content",
						"Labels": [],
						"Attributes": {
							"name": "apps.value.name",
							"value": "apps.value.network_interface..access_config..nat_ip",
						},
						"Blocks": [],
						"line_range": {
							"endLine": 17,
							"startLine": 14,
						},
					}],
					"line_range": {
						"endLine": 18,
						"startLine": 10,
					},
				}],
				"line_range": {
					"endLine": 19,
					"startLine": 8,
				},
			}],
			"line_range": {
				"endLine": 20,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 21,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloud_sql_publicly_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_sql_database_instance",
			"postgres",
		],
		"Attributes": {
			"database_version": "POSTGRES_15",
			"name": "random_id.db_name_suffix.hex",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {"tier": "db-f1-micro"},
			"Blocks": [{
				"Type": "ip_configuration",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "dynamic",
					"Labels": ["authorized_networks"],
					"Attributes": {
						"for_each": "google_compute_instance.apps",
						"iterator": "apps",
					},
					"Blocks": [{
						"Type": "content",
						"Labels": [],
						"Attributes": {
							"name": "apps.value.name",
							"value": "0.0.0.0/0",
						},
						"Blocks": [],
						"line_range": {
							"endLine": 17,
							"startLine": 14,
						},
					}],
					"line_range": {
						"endLine": 18,
						"startLine": 10,
					},
				}],
				"line_range": {
					"endLine": 19,
					"startLine": 8,
				},
			}],
			"line_range": {
				"endLine": 20,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 21,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
