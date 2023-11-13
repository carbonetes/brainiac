package lib.terraform.CB_TFGCP_045

test_vpc_flow_logs_intranode_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"example",
		],
		"Attributes": {"enable_intranode_visibility": true},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_vpc_flow_logs_intranode_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"example",
		],
		"Attributes": {"enable_intranode_visibility": false},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
