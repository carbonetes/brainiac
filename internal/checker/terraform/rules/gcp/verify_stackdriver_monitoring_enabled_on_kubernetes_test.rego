package lib.terraform.CB_TFGCP_015

test_stackdriver_monitoring_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"primary",
		],
		"Attributes": {
			"monitoring_service": "monitoring.googleapis.com/kubernetes",
			"name": "my-gke-cluster",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_stackdriver_monitoring_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"primary",
		],
		"Attributes": {
			"monitoring_service": "none",
			"name": "my-gke-cluster",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
