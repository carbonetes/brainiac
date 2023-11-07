package lib.terraform.CB_TFGCP_019

test_automatic_node_upgrade_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_node_pool",
			"np",
		],
		"Attributes": {"name": "my-node-pool"},
		"Blocks": [{
			"Type": "management",
			"Labels": [],
			"Attributes": {"auto_upgrade": true},
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

test_automatic_node_upgrade_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_node_pool",
			"np",
		],
		"Attributes": {"name": "my-node-pool"},
		"Blocks": [{
			"Type": "management",
			"Labels": [],
			"Attributes": {"auto_upgrade": false},
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
