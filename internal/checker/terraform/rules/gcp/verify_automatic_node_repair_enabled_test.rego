package lib.terraform.CB_TFGCP_017

test_automatic_node_repair_enabled {
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
			"Attributes": {"auto_repair": true},
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

test_automatic_node_repair_not_enabled {
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
			"Attributes": {"auto_repair": false},
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
