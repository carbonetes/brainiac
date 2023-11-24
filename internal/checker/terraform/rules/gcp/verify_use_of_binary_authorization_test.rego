package lib.terraform.CB_TFGCP_058

test_binary_authorization_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"example",
		],
		"Attributes": {
			"enable_binary_authorization": true,
			"name": "test",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_binary_authorization_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"example",
		],
		"Attributes": {
			"enable_binary_authorization": false,
			"name": "test",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
