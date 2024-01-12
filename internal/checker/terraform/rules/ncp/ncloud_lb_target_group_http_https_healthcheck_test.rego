package lib.terraform.CB_TFNCP_001

test_ncloud_lb_target_group_http_https_healthcheck_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_lb_target_group",
			"example",
		],
		"Attributes": {
			"name": "name",
			"port": "80",
			"protocol": "HTTPS",
		},
		"Blocks": [{
			"Type": "health_check",
			"Labels": [],
			"Attributes": {
				"healthy_threshold": "2",
				"interval": "30",
				"port": "80",
				"protocol": "HTTPS",
				"timeout": "3",
				"unhealthy_threshold": "2",
				"url_path": "your_health_check_path",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 14,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 15,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ncloud_lb_target_group_http_https_healthcheck_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_lb_target_group",
			"example",
		],
		"Attributes": {
			"name": "name",
			"port": "80",
			"protocol": "",
		},
		"Blocks": [{
			"Type": "health_check",
			"Labels": [],
			"Attributes": {
				"healthy_threshold": "2",
				"interval": "30",
				"port": "80",
				"protocol": "HTTPS",
				"timeout": "3",
				"unhealthy_threshold": "2",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 14,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 15,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
