package lib.terraform.CB_TFAWS_339

import rego.v1 

test_aws_cloudtrail_trails_integrated_with_cloudwatch_logs_passed if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_cloudtrail",
				"example",
			],
			"Attributes": {
				"cloud_watch_logs_group_arn": "aws_cloudwatch_log_group.example.arn",
				"cloud_watch_logs_role_arn": "aws_iam_role.example.arn",
				"enable_log_file_validation": true,
				"is_multi_region_trail": true,
				"name": "example-cloudtrail",
				"s3_bucket_name": "example-cloudtrail-bucket",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_cloudwatch_log_group",
				"example",
			],
			"Attributes": {"name": "example-cloudtrail-log-group"},
			"Blocks": [],
			"line_range": {
				"endLine": 12,
				"startLine": 10,
			},
		},
	]
	count(result) == 1
}

test_aws_cloudtrail_trails_integrated_with_cloudwatch_logs_failed if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_cloudtrail",
				"example",
			],
			"Attributes": {
				"cloud_watch_logs_group_arn": "",
				"cloud_watch_logs_role_arn": "aws_iam_role.example.arn",
				"enable_log_file_validation": true,
				"is_multi_region_trail": true,
				"name": "example-cloudtrail",
				"s3_bucket_name": "example-cloudtrail-bucket",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_cloudwatch_log_group",
				"example",
			],
			"Attributes": {"name": "example-cloudtrail-log-group"},
			"Blocks": [],
			"line_range": {
				"endLine": 12,
				"startLine": 10,
			},
		},
	]
	count(result) == 1
}
