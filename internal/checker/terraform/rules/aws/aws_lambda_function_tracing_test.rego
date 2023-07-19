package lib.terraform.CB_TFAWS_026

test_aws_function_tracing {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lambda_function",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "tracing_config",
			"Labels": [],
			"Attributes": {"mode": "PassThrough"},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_function_no_tracing {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lambda_function",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "tracing_config",
			"Labels": [],
			"Attributes": {"mode": "Inactive"},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
