package lib.terraform.CB_TFAWS_366

test_aws_lb_listener_alb_redirects_http_requests_into_https_passed {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_lb",
				"lb_good",
			],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 2,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_lb_listener",
				"listener_good",
			],
			"Attributes": {
				"load_balancer_arn": "aws_lb.lb_good.arn",
				"port": "80",
				"protocol": "HTTP",
			},
			"Blocks": [{
				"Type": "default_action",
				"Labels": [],
				"Attributes": {"type": "redirect"},
				"Blocks": [{
					"Type": "redirect",
					"Labels": [],
					"Attributes": {
						"port": "443",
						"protocol": "HTTPS",
						"status_code": "HTTP_301",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 17,
						"startLine": 13,
					},
				}],
				"line_range": {
					"endLine": 19,
					"startLine": 10,
				},
			}],
			"line_range": {
				"endLine": 20,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}

test_aws_lb_listener_alb_redirects_http_requests_into_https_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_lb",
				"lb_good",
			],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 2,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_lb_listener",
				"listener_good",
			],
			"Attributes": {
				"load_balancer_arn": "aws_lb.lb_good.arn",
				"port": "8080",
				"protocol": "TCP",
			},
			"Blocks": [{
				"Type": "default_action",
				"Labels": [],
				"Attributes": {"type": "redirect"},
				"Blocks": [{
					"Type": "not_redirect",
					"Labels": [],
					"Attributes": {
						"port": "8080",
						"protocol": "TCP",
						"status_code": "HTTP_301",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 17,
						"startLine": 13,
					},
				}],
				"line_range": {
					"endLine": 19,
					"startLine": 10,
				},
			}],
			"line_range": {
				"endLine": 20,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}
