package lib.terraform.CB_TFAWS_254

import rego.v1

test_target_group_http_https_defines_healthcheck if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_alb_target_group",
			"example",
		],
		"Attributes": {
			"name": "target-group-1",
			"port": "80",
			"protocol": "HTTPS",
		},
		"Blocks": [{
			"Type": "health_check",
			"Labels": [],
			"Attributes": {
				"matcher": "200",
				"path": "/api/1/resolve/default?path=/service/my-service",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_target_group_http_https_not_defines_healthcheck if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_alb_target_group",
			"example",
		],
		"Attributes": {
			"name": "target-group-1",
			"port": "80",
			"protocol": "HTTPS",
		},
		"Blocks": [{
			"Type": "health_check",
			"Labels": [],
			"Attributes": {"matcher": "200"},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
