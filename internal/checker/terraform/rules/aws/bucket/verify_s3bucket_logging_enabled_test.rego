package lib.terraform.CB_TFAWS_023
import rego.v1

test_s3_bucket_logging_enabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_s3_bucket",
			"example_bucket",
		],
		"Attributes": {"bucket": "example-bucket"},
		"Blocks": [{
			"Type": "logging",
			"Labels": [],
			"Attributes": {
				"target_bucket": "example-logs-bucket",
				"target_prefix": "example-bucket-logs/",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_s3_bucket_no_logging if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_s3_bucket",
			"example_bucket",
		],
		"Attributes": {"bucket": "example-bucket"},
		"Blocks": [],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
