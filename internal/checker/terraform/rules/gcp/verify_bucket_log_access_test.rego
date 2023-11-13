package lib.terraform.CB_TFGCP_046

test_bucket_log_access_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_storage_bucket",
			"logging",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "logging",
			"Labels": [],
			"Attributes": {"log_bucket": "mylovelybucket"},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_bucket_log_access_not_set {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_storage_bucket",
			"logging",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "logging",
			"Labels": [],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
