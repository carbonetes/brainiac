package lib.terraform.CB_TFAWS_106
import rego.v1

test_aws_lamda_dead_letter_configured if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lambda_function",
			"test_lambda",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "dead_letter_config",
			"Labels": [],
			"Attributes": {"target_arn": "test"},
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

test_aws_lamda_dead_letter_configured_not_set if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_lambda_function",
			"test_lambda",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "dead_letter_config",
			"Labels": [],
			"Attributes": {},
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
