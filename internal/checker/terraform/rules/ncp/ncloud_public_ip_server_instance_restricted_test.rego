package lib.terraform.CB_TFNCP_022

test_ncloud_public_ip_server_instance_restricted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_public_ip",
			"example",
		],
		"Attributes": {},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ncloud_public_ip_server_instance_restricted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_public_ip",
			"example",
		],
		"Attributes": {"server_instance_no": "your_server_instance_id"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
