package lib.terraform.CB_TFGCP_039

test_gke_basic_auth_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"pass2",
		],
		"Attributes": {"name": "google_cluster"},
		"Blocks": [{
			"Type": "master_auth",
			"Labels": [],
			"Attributes": {
				"password": "",
				"username": "",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_gke_basic_auth_not_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"pass2",
		],
		"Attributes": {"name": "google_cluster"},
		"Blocks": [{
			"Type": "master_auth",
			"Labels": [],
			"Attributes": {
				"password": "test",
				"username": "test_password",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
