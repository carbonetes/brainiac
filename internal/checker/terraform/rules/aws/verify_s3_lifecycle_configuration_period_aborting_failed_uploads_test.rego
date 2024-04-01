package lib.terraform.CB_TFAWS_275

import rego.v1 

test_s3_lifecycle_cofig_set_period_aborting_uploads if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_s3_bucket_lifecycle_configuration",
			"example_lifecycle",
		],
		"Attributes": {"bucket": "aws_s3_bucket.example_bucket.id"},
		"Blocks": [{
			"Type": "rule",
			"Labels": [],
			"Attributes": {
				"id": "abort-incomplete-uploads",
				"status": "Enabled",
			},
			"Blocks": [{
				"Type": "abort_incomplete_multipart_upload",
				"Labels": [],
				"Attributes": {
					"days_after_initiation": "7",
					"filter": "1",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 9,
					"startLine": 6,
				},
			}],
			"line_range": {
				"endLine": 10,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_s3_lifecycle_cofig_not_set_period_aborting_uploads if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_s3_bucket_lifecycle_configuration",
			"example_lifecycle",
		],
		"Attributes": {"bucket": "aws_s3_bucket.example_bucket.id"},
		"Blocks": [{
			"Type": "rule",
			"Labels": [],
			"Attributes": {
				"id": "abort-incomplete-uploads",
				"status": "Enabled",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
