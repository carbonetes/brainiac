package lib.terraform.CB_TFAWS_248

import rego.v1 

test_aws_lambda_function_configured_to_validate_code_signing_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lambda_function",
			"example",
		],
		"Attributes": {"code_signing_config_arn": "code_signing_config_arn"},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_lambda_function_configured_to_validate_code_signing_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lambda_function",
			"example",
		],
		"Attributes": {"code_signing_config_arn": ""},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
