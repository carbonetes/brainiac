package lib.terraform.CB_TFAWS_240
import rego.v1

test_lamda_function_urls_authtype_not_none if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lambda_function_url",
			"pass",
		],
		"Attributes": {
			"authorization_type": "AWS_IAM",
			"function_name": "aws_lambda_function.test.function_name",
			"qualifier": "my_alias",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_lamda_function_urls_authtype_none if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lambda_function_url",
			"pass",
		],
		"Attributes": {
			"authorization_type": "NONE",
			"function_name": "aws_lambda_function.test.function_name",
			"qualifier": "my_alias",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
