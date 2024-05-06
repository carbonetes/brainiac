package lib.terraform.CB_TFAWS_362

import rego.v1 

test_s3_has_lifecycle_configuration if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_s3_bucket",
			"example_bucket",
		],
		"Attributes": {
			"acl": "private",
			"bucket": "example-bucket-name",
		},
		"Blocks": [{
			"Type": "lifecycle_rule",
			"Labels": [],
			"Attributes": {
				"id": "example-lifecycle-rule",
				"status": "enabled",
			},
			"Blocks": [{
				"Type": "transition",
				"Labels": [],
				"Attributes": {
					"days": "30",
					"storage_class": "GLACIER",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 12,
					"startLine": 9,
				},
			}],
			"line_range": {
				"endLine": 13,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_s3_has_no_lifecycle_configuration if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_s3_bucket",
			"example_bucket",
		],
		"Attributes": {
			"acl": "private",
			"bucket": "example-bucket-name",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
