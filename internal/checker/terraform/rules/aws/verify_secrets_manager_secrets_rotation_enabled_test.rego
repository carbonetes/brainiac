package lib.terraform.CB_TFAWS_355

import rego.v1 

test_secrets_manager_secrets_rotation_enabled if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_secretsmanager_secret",
				"example_secret",
			],
			"Attributes": {
				"description": "Example Secrets Manager secret",
				"name": "example-secret",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_secretsmanager_secret_rotation",
				"example_rotation",
			],
			"Attributes": {
				"rotation_lambda_arn": "arn:aws:lambda:us-east-1:123456789012:function:example-rotation-lambda",
				"secret_id": "aws_secretsmanager_secret.example_secret.id",
			},
			"Blocks": [{
				"Type": "rotation_rules",
				"Labels": [],
				"Attributes": {"automatically_after_days": "30"},
				"Blocks": [],
				"line_range": {
					"endLine": 11,
					"startLine": 9,
				},
			}],
			"line_range": {
				"endLine": 12,
				"startLine": 6,
			},
		},
	]
	count(result) == 1
}

test_sagemakernotebook_user_root_access_enabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_secretsmanager_secret",
			"example_secret",
		],
		"Attributes": {
			"description": "Example Secrets Manager secret",
			"name": "example-secret",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
