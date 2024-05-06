package lib.terraform.CB_TFAWS_231
import rego.v1

test_cloudtrail_sns_topic_defined if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudtrail",
			"pass",
		],
		"Attributes": {
			"enable_logging": true,
			"include_global_service_events": true,
			"kms_key_id": "aws_kms_key.test.arn",
			"name": "TRAIL",
			"s3_bucket_name": "aws_s3_bucket.test.id",
			"sns_topic_name": "aws_sns_topic.notes.arn",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloudtrail_sns_topic_not_defined if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudtrail",
			"pass",
		],
		"Attributes": {
			"enable_logging": true,
			"include_global_service_events": true,
			"kms_key_id": "aws_kms_key.test.arn",
			"name": "TRAIL",
			"s3_bucket_name": "aws_s3_bucket.test.id",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
