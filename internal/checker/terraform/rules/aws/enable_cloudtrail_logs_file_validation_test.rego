package lib.terraform.CB_TFAWS_033
import rego.v1

test_cloudtrail_logs_file_validation_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudtrail",
			"example",
		],
		"Attributes": {
			"enable_log_file_validation": true,
			"enable_logging": true,
			"include_global_service_events": true,
			"is_multi_region_trail": true,
			"name": "example-cloudtrail",
			"s3_bucket_name": "example-bucket",
			"s3_key_prefix": "cloudtrail-logs",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloudtrail_logs_file_validation_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudtrail",
			"example",
		],
		"Attributes": {
			"enable_log_file_validation": false,
			"enable_logging": true,
			"include_global_service_events": true,
			"is_multi_region_trail": true,
			"name": "example-cloudtrail",
			"s3_bucket_name": "example-bucket",
			"s3_key_prefix": "cloudtrail-logs",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
