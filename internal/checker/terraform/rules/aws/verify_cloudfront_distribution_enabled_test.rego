package lib.terraform.CB_TFAWS_202

test_cloudfront_distribution_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudfront_distribution",
			"pass",
		],
		"Attributes": {"enabled": true},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloudfront_distribution_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudfront_distribution",
			"pass",
		],
		"Attributes": {"enabled": false},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
