package lib.terraform.CB_TFGCP_090

test_cloud_build_workers_private {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_cloudbuild_worker_pool",
			"pass",
		],
		"Attributes": {"name": "test-pool"},
		"Blocks": [{
			"Type": "worker_config",
			"Labels": [],
			"Attributes": {"no_external_ip": true},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloud_build_workers_not_private {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_cloudbuild_worker_pool",
			"pass",
		],
		"Attributes": {"name": "test-pool"},
		"Blocks": [{
			"Type": "worker_config",
			"Labels": [],
			"Attributes": {"no_external_ip": false},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
