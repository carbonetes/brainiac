package lib.terraform.CB_TFNCP_015

test_ncloud_lb_target_group_http_restricted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_lb_target_group",
			"example",
		],
		"Attributes": {
			"name": "example-target-group",
			"port": "443",
			"protocol": "HTTPS",
			"target_group_healthy": "1",
			"target_group_termination": false,
			"target_group_unhealthy": "1",
			"target_type": "IP",
			"vpc_id": "ncloud_vpc.example.id",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ncloud_lb_target_group_http_restricted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_lb_target_group",
			"example",
		],
		"Attributes": {
			"name": "example-target-group",
			"port": "443",
			"protocol": "HTTP",
			"target_group_healthy": "1",
			"target_group_termination": false,
			"target_group_unhealthy": "1",
			"target_type": "IP",
			"vpc_id": "ncloud_vpc.example.id",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
