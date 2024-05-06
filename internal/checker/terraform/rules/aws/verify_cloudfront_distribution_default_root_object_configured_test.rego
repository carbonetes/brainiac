package lib.terraform.CB_TFAWS_287

import rego.v1 

test_cloudfront_default_root_object_is_set if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudfront_distribution",
			"s3_distribution",
		],
		"Attributes": {
			"comment": "Some comment",
			"default_root_object": "index.html",
			"enabled": true,
			"is_ipv6_enabled": true,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_cloudfront_default_root_object_is_not_set if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudfront_distribution",
			"s3_distribution",
		],
		"Attributes": {
			"comment": "Some comment",
			"enabled": true,
			"is_ipv6_enabled": true,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
