package lib.terraform.CB_TFGCP_023

test_client_certificate_authentication_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"primary",
		],
		"Attributes": {
			"initial_node_count": "3",
			"location": "us-central1-a",
			"name": "marcellus-wallace",
		},
		"Blocks": [{
			"Type": "master_auth",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "client_certificate_config",
				"Labels": [],
				"Attributes": {"issue_client_certificate": false},
				"Blocks": [],
				"line_range": {
					"endLine": 8,
					"startLine": 6,
				},
			}],
			"line_range": {
				"endLine": 9,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_client_certificate_authentication_not_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"primary",
		],
		"Attributes": {
			"initial_node_count": "3",
			"location": "us-central1-a",
			"name": "marcellus-wallace",
		},
		"Blocks": [{
			"Type": "master_auth",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "client_certificate_config",
				"Labels": [],
				"Attributes": {"issue_client_certificate": true},
				"Blocks": [],
				"line_range": {
					"endLine": 8,
					"startLine": 6,
				},
			}],
			"line_range": {
				"endLine": 9,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
