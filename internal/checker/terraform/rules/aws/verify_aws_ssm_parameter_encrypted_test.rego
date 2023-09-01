package lib.terraform.CB_TFAWS_336

test_ssm_parameter_encrypted {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_ssm_parameter",
			"aws_ssm_parameter_ok",
		],
		"Attributes": {
			"allowed_pattern": ".*",
			"data_type": "text",
			"description": "policy test",
			"name": "sample",
			"tier": "Standard",
			"type": "SecureString",
			"value": "test",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_ssm_parameter_not_encrypted {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_ssm_parameter",
			"aws_ssm_parameter_ok",
		],
		"Attributes": {
			"allowed_pattern": ".*",
			"data_type": "text",
			"description": "policy test",
			"name": "sample",
			"tier": "Standard",
			"value": "test",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
