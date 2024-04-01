package lib.terraform.CB_TFAWS_285

import rego.v1

test_secrets_manager_rotations_set_within_90_days if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_secretsmanager_secret_rotation",
			"example",
		],
		"Attributes": {
			"rotation_lambda_arn": "aws_lambda_function.example.arn",
			"secret_id": "aws_secretsmanager_secret.example.id",
		},
		"Blocks": [{
			"Type": "rotation_rules",
			"Labels": [],
			"Attributes": {"automatically_after_days": "90"},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_secrets_manager_rotations_set_more_than_90_days if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_secretsmanager_secret_rotation",
			"example",
		],
		"Attributes": {
			"rotation_lambda_arn": "aws_lambda_function.example.arn",
			"secret_id": "aws_secretsmanager_secret.example.id",
		},
		"Blocks": [{
			"Type": "rotation_rules",
			"Labels": [],
			"Attributes": {"automatically_after_days": "100"},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
