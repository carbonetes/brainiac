package lib.terraform.CB_TFAWS_325

import rego.v1

test_public_facing_alb_waf_protected if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lb",
			"lb_good_1",
		],
		"Attributes": {
			"internal": false,
			"load_balancer_type": "gateway",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_public_facing_alb_not_waf_protected if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lb",
			"lb_good_1",
		],
		"Attributes": {
			"internal": false,
			"load_balancer_type": "application",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
