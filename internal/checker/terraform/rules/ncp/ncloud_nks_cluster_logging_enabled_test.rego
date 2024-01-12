package lib.terraform.CB_TFNCP_021

test_ncloud_nks_cluster_logging_enabled_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_nks_cluster",
			"example_cluster",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "log",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "audit",
				"Labels": [],
				"Attributes": {"enabled": true},
				"Blocks": [],
				"line_range": {
					"endLine": 8,
					"startLine": 5,
				},
			}],
			"line_range": {
				"endLine": 9,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ncloud_nks_cluster_logging_enabled_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_nks_cluster",
			"example_cluster",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "log",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "audit",
				"Labels": [],
				"Attributes": {},
				"Blocks": [],
				"line_range": {
					"endLine": 8,
					"startLine": 5,
				},
			}],
			"line_range": {
				"endLine": 9,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
