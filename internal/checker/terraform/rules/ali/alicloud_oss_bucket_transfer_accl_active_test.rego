package lib.terraform.CB_TFALI_015

test_alicloud_oss_bucket_transfer_accl_active_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_oss_bucket",
			"pass",
		],
		"Attributes": {"bucket": "bucket_name"},
		"Blocks": [{
			"Type": "transfer_acceleration",
			"Labels": [],
			"Attributes": {"enabled": true},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_alicloud_oss_bucket_transfer_accl_active_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_oss_bucket",
			"pass",
		],
		"Attributes": {"bucket": "bucket_name"},
		"Blocks": [{
			"Type": "transfer_acceleration",
			"Labels": [],
			"Attributes": {"enabled": false},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
