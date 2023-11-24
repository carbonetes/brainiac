package lib.terraform.CB_TFGCP_047

test_bucket_not_log_to_itself {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_storage_bucket",
			"logging",
		],
		"Attributes": {"name": "carbobucket"},
		"Blocks": [{
			"Type": "logging",
			"Labels": [],
			"Attributes": {"log_bucket": "newcarbobucket"},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_bucket_log_to_itself {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_storage_bucket",
			"logging",
		],
		"Attributes": {"name": "carbobucket"},
		"Blocks": [{
			"Type": "logging",
			"Labels": [],
			"Attributes": {"log_bucket": "carbobucket"},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
