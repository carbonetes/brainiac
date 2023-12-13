package lib.terraform.CB_TFALI_016

test_alicloud_oss_bucket_access_log_active_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_oss_bucket",
			"pass",
		],
		"Attributes": {"bucket": "bucket-170309-logging"},
		"Blocks": [{
			"Type": "logging",
			"Labels": [],
			"Attributes": {
				"target_bucket": "alicloud_oss_bucket.bucket-target.id",
				"target_prefix": "log/",
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

test_alicloud_oss_bucket_access_log_active_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_oss_bucket",
			"pass",
		],
		"Attributes": {"bucket": "bucket-170309-logging"},
		"Blocks": [{
			"Type": "not_logging",
			"Labels": [],
			"Attributes": {
				"target_bucket": "alicloud_oss_bucket.bucket-target.id",
				"target_prefix": "log/",
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
