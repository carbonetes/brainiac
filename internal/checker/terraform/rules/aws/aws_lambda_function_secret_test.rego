package lib.terraform.CB_TFAWS_040
import rego.v1

test_aws_lambda_function_secret_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lambda_function",
			"fail",
		],
		"Attributes": {
			"function_name": "test-env",
			"role": "",
			"runtime": "python3.8",
		},
		"Blocks": [{
			"Type": "environment",
			"Labels": [],
			"Attributes": {"variables": {
				"AWS_ACCESS_KEY_ID": "AKIAIOSFOsddaDNN7EXAMPLE",
				"AWS_DEFAULT_REGION": "us-west-2",
				"AWS_SECRET_ACCESS_KEY": "wJalrXUtnFaY",
			}},
			"Blocks": [],
			"line_range": {
				"endLine": 12,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_lambda_function_secret_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lambda_function",
			"fail",
		],
		"Attributes": {
			"function_name": "test-env",
			"role": "",
			"runtime": "python3.8",
		},
		"Blocks": [{
			"Type": "environment",
			"Labels": [],
			"Attributes": {"variables": {
				"AWS_ACCESS_KEY_ID": "AKIAIOSFODNN7EXAMPLE",
				"AWS_DEFAULT_REGION": "us-west-2",
				"AWS_SECRET_ACCESS_KEY": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
			}},
			"Blocks": [],
			"line_range": {
				"endLine": 12,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
