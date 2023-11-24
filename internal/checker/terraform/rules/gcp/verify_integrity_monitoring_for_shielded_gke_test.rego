package lib.terraform.CB_TFGCP_063

test_monitoring_for_shielded_gke {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"fail",
		],
		"Attributes": {"name": "success"},
		"Blocks": [{
			"Type": "node_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "shielded_instance_config",
				"Labels": [],
				"Attributes": {"enable_integrity_monitoring": true},
				"Blocks": [],
				"line_range": {
					"endLine": 7,
					"startLine": 5,
				},
			}],
			"line_range": {
				"endLine": 8,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_monitoring_for_shielded_gke_set_to_false {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"fail",
		],
		"Attributes": {"name": "success"},
		"Blocks": [{
			"Type": "node_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "shielded_instance_config",
				"Labels": [],
				"Attributes": {"enable_integrity_monitoring": false},
				"Blocks": [],
				"line_range": {
					"endLine": 7,
					"startLine": 5,
				},
			}],
			"line_range": {
				"endLine": 8,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
