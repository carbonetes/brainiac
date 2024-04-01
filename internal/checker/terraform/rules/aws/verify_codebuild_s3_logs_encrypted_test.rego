package lib.terraform.CB_TFAWS_294

import rego.v1 

test_codebuild_s3_logs_encrypted if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_codebuild_project",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "logs_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [
				{
					"Type": "cloudwatch_logs",
					"Labels": [],
					"Attributes": {
						"group_name": "log-group",
						"stream_name": "log-stream",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 7,
						"startLine": 4,
					},
				},
				{
					"Type": "s3_logs",
					"Labels": [],
					"Attributes": {
						"encryption_disabled": false,
						"location": "aws_s3_bucket.example.id",
						"status": "ENABLED",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 13,
						"startLine": 9,
					},
				},
			],
			"line_range": {
				"endLine": 14,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 15,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_codebuild_s3_logs_not_encrypted if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_codebuild_project",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "logs_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [
				{
					"Type": "cloudwatch_logs",
					"Labels": [],
					"Attributes": {
						"group_name": "log-group",
						"stream_name": "log-stream",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 7,
						"startLine": 4,
					},
				},
				{
					"Type": "s3_logs",
					"Labels": [],
					"Attributes": {
						"encryption_disabled": true,
						"location": "aws_s3_bucket.example.id",
						"status": "ENABLED",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 13,
						"startLine": 9,
					},
				},
			],
			"line_range": {
				"endLine": 14,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 15,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
