package lib.terraform.CB_TFAWS_130
import rego.v1

test_alb_http_headers_drops if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_alb",
			"test_success",
		],
		"Attributes": {
			"drop_invalid_header_fields": true,
			"internal": false,
			"load_balancer_type": "network",
			"name": "test-lb-tf",
			"subnets": "aws_subnet.public",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_alb_http_headers_not_drop if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_alb",
			"test_success",
		],
		"Attributes": {
			"drop_invalid_header_fields": false,
			"internal": false,
			"load_balancer_type": "network",
			"name": "test-lb-tf",
			"subnets": "aws_subnet.public",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
