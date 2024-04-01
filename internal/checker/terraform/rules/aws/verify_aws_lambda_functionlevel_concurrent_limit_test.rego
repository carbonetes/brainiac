package lib.terraform.CB_TFAWS_104
import rego.v1

test_aws_lamda_function_leven_concurrent_exec_limit_set if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lambda_function",
			"example",
		],
		"Attributes": {"reserved_concurrent_executions": "100"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_aws_lamda_function_leven_concurrent_exec_not_set if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lambda_function",
			"example",
		],
		"Attributes": {},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
