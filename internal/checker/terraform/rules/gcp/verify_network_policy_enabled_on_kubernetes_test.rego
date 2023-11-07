package lib.terraform.CB_TFGCP_021

test_netork_policy_enabled_on_kubernetes {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"pass",
		],
		"Attributes": {"name": "google_cluster"},
		"Blocks": [{
			"Type": "network_policy",
			"Labels": [],
			"Attributes": {"enabled": true},
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

test_netork_policy_not_enabled_on_kubernetes {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"pass",
		],
		"Attributes": {"name": "google_cluster"},
		"Blocks": [{
			"Type": "network_policy",
			"Labels": [],
			"Attributes": {"enabled": false},
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
