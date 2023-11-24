package lib.terraform.CB_TFGCP_001

test_logging_enabled_on_cluster {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"primary",
		],
		"Attributes": {
			"initial_node_count": "1",
			"location": "us-central1",
			"logging_service": "logging.googleapis.com/kubernetes",
			"name": "my-gke-cluster",
			"remove_default_node_pool": true,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_logging_not_enabled_on_cluster {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"primary",
		],
		"Attributes": {
			"initial_node_count": "1",
			"location": "us-central1",
			"logging_service": "none",
			"name": "my-gke-cluster",
			"remove_default_node_pool": true,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
