package lib.terraform.CB_TFAWS_363

import rego.v1 

test_s3_notification_enabled if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_s3_bucket",
				"bucket",
			],
			"Attributes": {"bucket": "your-bucket-name"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_s3_bucket_notification",
				"bucket_notification",
			],
			"Attributes": {"bucket": "aws_s3_bucket.bucket.id"},
			"Blocks": [{
				"Type": "topic",
				"Labels": [],
				"Attributes": {
					"events": ["s3:ObjectCreated:*"],
					"filter_suffix": ".log",
					"topic_arn": "aws_sns_topic.topic.arn",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 12,
					"startLine": 8,
				},
			}],
			"line_range": {
				"endLine": 13,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}

test_s3_notification_not_enabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_s3_bucket",
			"bucket",
		],
		"Attributes": {"bucket": "your-bucket-name"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
