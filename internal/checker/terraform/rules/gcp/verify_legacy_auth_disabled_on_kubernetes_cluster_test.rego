package lib.terraform.CB_TFGCP_011

test_legacy_auth_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"primary",
		],
		"Attributes": {
			"enable_legacy_abac": false,
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

test_legacy_auth_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"primary",
		],
		"Attributes": {
			"enable_legacy_abac": true,
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
