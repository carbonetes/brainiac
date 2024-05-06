package lib.terraform.CB_TFAWS_032
import rego.v1

test_cloudtrail_logs_encryption_at_rest_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudtrail",
			"example",
		],
		"Attributes": {
			"include_global_service_events": true,
			"is_multi_region_trail": true,
			"kms_key_id": "alias/aws/s3",
			"name": "example",
		},
		"Blocks": [{
			"Type": "event_selector",
			"Labels": [],
			"Attributes": {
				"include_management_events": true,
				"read_write_type": "All",
			},
			"Blocks": [{
				"Type": "data_resource",
				"Labels": [],
				"Attributes": {
					"type": "AWS::S3::Object",
					"values": ["arn:aws:s3:::example_bucket"],
				},
				"Blocks": [],
				"line_range": {
					"endLine": 18,
					"startLine": 15,
				},
			}],
			"line_range": {
				"endLine": 19,
				"startLine": 12,
			},
		}],
		"line_range": {
			"endLine": 24,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloudtrail_logs_encryption_at_rest_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudtrail",
			"example",
		],
		"Attributes": {
			"include_global_service_events": true,
			"is_multi_region_trail": true,
			"name": "example",
		},
		"Blocks": [{
			"Type": "event_selector",
			"Labels": [],
			"Attributes": {
				"include_management_events": true,
				"read_write_type": "All",
			},
			"Blocks": [{
				"Type": "data_resource",
				"Labels": [],
				"Attributes": {
					"type": "AWS::S3::Object",
					"values": ["arn:aws:s3:::example_bucket"],
				},
				"Blocks": [],
				"line_range": {
					"endLine": 18,
					"startLine": 15,
				},
			}],
			"line_range": {
				"endLine": 19,
				"startLine": 12,
			},
		}],
		"line_range": {
			"endLine": 24,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
