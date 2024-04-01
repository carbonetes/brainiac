package lib.terraform.CB_TFAWS_230
import rego.v1

test_cloudtrail_logging_enabled if {
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
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloudtrail_logging_not_enabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudtrail",
			"pass",
		],
		"Attributes": {
			"enable_logging": false,
			"include_global_service_events": true,
			"kms_key_id": "aws_kms_key.test.arn",
			"name": "TRAIL",
			"s3_bucket_name": "aws_s3_bucket.test.id",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
