package lib.terraform.CB_TFNCP_019

test_ncloud_route_default_route_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_route",
			"example",
		],
		"Attributes": {
			"destination_cidr_block": "0.0.0.0/0",
			"target_type": "NATGW",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ncloud_route_default_route_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_route",
			"example",
		],
		"Attributes": {
			"destination_cidr_block": "10.0.0.0/8",
			"target_type": "NATGW",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
