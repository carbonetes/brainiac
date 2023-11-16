package lib.terraform.CB_TFGCP_075

test_cloud_storage_versioning_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_storage_bucket",
			"pass",
		],
		"Attributes": {"name": "test"},
		"Blocks": [{
			"Type": "versioning",
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

test_cloud_storage_versioning_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_storage_bucket",
			"pass",
		],
		"Attributes": {"name": "test"},
		"Blocks": [{
			"Type": "versioning",
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
