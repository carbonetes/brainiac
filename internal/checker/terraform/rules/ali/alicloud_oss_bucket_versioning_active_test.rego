package lib.terraform.CB_TFALI_014

test_alicloud_oss_bucket_versioning_active_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_oss_bucket",
			"pass",
		],
		"Attributes": {
			"acl": "private",
			"bucket": "bucket-123-versioning",
		},
		"Blocks": [{
			"Type": "versioning",
			"Labels": [],
			"Attributes": {"status": "Enabled"},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_alicloud_oss_bucket_versioning_active_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_oss_bucket",
			"pass",
		],
		"Attributes": {
			"acl": "private",
			"bucket": "bucket-123-versioning",
		},
		"Blocks": [{
			"Type": "versioning",
			"Labels": [],
			"Attributes": {"status": ""},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
