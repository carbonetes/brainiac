package lib.terraform.CB_TFAWS_284

import rego.v1

test_aws_cloudtrail_event_data_store_utilizing_cmk_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudtrail_event_data_store",
			"example",
		],
		"Attributes": {
			"bucket": "aws_s3_bucket.example.id",
			"kms_key_id": "aws_kms_key.example.arn",
			"name": "example-cloudtrail-event-data-store",
			"region": "us-east-1",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_cloudtrail_event_data_store_utilizing_cmk_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudtrail_event_data_store",
			"example",
		],
		"Attributes": {
			"bucket": "aws_s3_bucket.example.id",
			"kms_key_id": "",
			"name": "example-cloudtrail-event-data-store",
			"region": "us-east-1",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
