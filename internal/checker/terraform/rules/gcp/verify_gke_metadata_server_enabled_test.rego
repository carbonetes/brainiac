package lib.terraform.CB_TFGCP_060

test_gke_metadata_server_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"success",
		],
		"Attributes": {"name": "success"},
		"Blocks": [{
			"Type": "node_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "workload_metadata_config",
				"Labels": [],
				"Attributes": {"node_metadata": "GKE_METADATA_SERVER"},
				"Blocks": [],
				"line_range": {
					"endLine": 7,
					"startLine": 5,
				},
			}],
			"line_range": {
				"endLine": 8,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_gke_metadata_server_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"success",
		],
		"Attributes": {"name": "success"},
		"Blocks": [{
			"Type": "node_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "workload_metadata_config",
				"Labels": [],
				"Attributes": {},
				"Blocks": [],
				"line_range": {
					"endLine": 7,
					"startLine": 5,
				},
			}],
			"line_range": {
				"endLine": 8,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
