package lib.terraform.CB_TFGCP_059

test_secure_boot_shielded_gke_node {
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
			"Blocks": [
				{
					"Type": "workload_metadata_config",
					"Labels": [],
					"Attributes": {"node_metadata": "GKE_METADATA_SERVER"},
					"Blocks": [],
					"line_range": {
						"endLine": 7,
						"startLine": 5,
					},
				},
				{
					"Type": "shielded_instance_config",
					"Labels": [],
					"Attributes": {"enable_secure_boot": true},
					"Blocks": [],
					"line_range": {
						"endLine": 10,
						"startLine": 8,
					},
				},
			],
			"line_range": {
				"endLine": 11,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_secure_boot_shielded_gke_node_disabled {
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
			"Blocks": [
				{
					"Type": "workload_metadata_config",
					"Labels": [],
					"Attributes": {"node_metadata": "GKE_METADATA_SERVER"},
					"Blocks": [],
					"line_range": {
						"endLine": 7,
						"startLine": 5,
					},
				},
				{
					"Type": "shielded_instance_config",
					"Labels": [],
					"Attributes": {"enable_secure_boot": false},
					"Blocks": [],
					"line_range": {
						"endLine": 10,
						"startLine": 8,
					},
				},
			],
			"line_range": {
				"endLine": 11,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
