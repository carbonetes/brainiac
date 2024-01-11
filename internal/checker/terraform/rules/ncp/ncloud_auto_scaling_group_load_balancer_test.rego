package lib.terraform.CB_TFNCP_017

test_ncloud_auto_scaling_group_load_balancer_passed {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"ncloud_auto_scaling_group",
				"example",
			],
			"Attributes": {
				"desired_capacity": "2",
				"health_check_type_code": "LOADB",
				"lb_target_group": "ncloud_lb_target_group.example.id",
				"max_size": "3",
				"min_size": "1",
				"name": "example-asg",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"ncloud_lb_target_group",
				"example",
			],
			"Attributes": {
				"name": "example-lb-tg",
				"port": "80",
				"protocol": "HTTP",
				"vpc_id": "ncloud_vpc.example.id",
			},
			"Blocks": [{
				"Type": "health_check",
				"Labels": [],
				"Attributes": {
					"healthy_threshold": "3",
					"interval": "30",
					"path": "/",
					"port": "80",
					"protocol": "HTTP",
					"timeout": "3",
					"unhealthy_threshold": "3",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 24,
					"startLine": 16,
				},
			}],
			"line_range": {
				"endLine": 25,
				"startLine": 11,
			},
		},
	]
	count(result) == 1
}

test_ncloud_auto_scaling_group_load_balancer_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"ncloud_auto_scaling_group",
				"example",
			],
			"Attributes": {
				"desired_capacity": "2",
				"health_check_type_code": "",
				"max_size": "3",
				"min_size": "1",
				"name": "example-asg",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"ncloud_lb_target_group",
				"example",
			],
			"Attributes": {
				"name": "example-lb-tg",
				"port": "80",
				"protocol": "HTTP",
				"vpc_id": "ncloud_vpc.example.id",
			},
			"line_range": {
				"endLine": 25,
				"startLine": 11,
			},
		},
	]
	count(result) == 1
}
