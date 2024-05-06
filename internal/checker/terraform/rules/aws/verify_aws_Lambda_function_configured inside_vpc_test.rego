package lib.terraform.CB_TFAWS_108
import rego.v1

test_aws_lamda_function_configured_inside_vpc if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lambda_function",
			"example_lambda",
		],
		"Attributes": {
			"function_name": "example_lambda_function",
			"handler": "example_lambda.handler",
			"runtime": "python3.8",
			"timeout": "60",
		},
		"Blocks": [{
			"Type": "vpc_config",
			"Labels": [],
			"Attributes": {"security_group_ids": ["sg-12345678"]},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 7,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_aws_lamda_function_configured_inside_vpc_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lambda_function",
			"example_lambda",
		],
		"Attributes": {
			"function_name": "example_lambda_function",
			"handler": "example_lambda.handler",
			"runtime": "python3.8",
			"timeout": "60",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
