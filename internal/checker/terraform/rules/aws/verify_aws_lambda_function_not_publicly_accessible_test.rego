package lib.terraform.CB_TFAWS_277

test_aws_lamda_function_not_publicly_accesible {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lambda_permission",
			"invoke_permissions",
		],
		"Attributes": {
			"action": "lambda:InvokeFunction",
			"function_name": "aws_lambda_function.example_lambda_function.arn",
			"principal": "events.amazonaws.com",
			"statement_id": "AllowLambdaInvokeFromSpecificServices",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_lamda_function_publicly_accesible {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lambda_permission",
			"invoke_permissions",
		],
		"Attributes": {
			"action": "lambda:InvokeFunction",
			"function_name": "aws_lambda_function.example_lambda_function.arn",
			"principal": "*",
			"statement_id": "AllowLambdaInvokeFromSpecificServices",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
