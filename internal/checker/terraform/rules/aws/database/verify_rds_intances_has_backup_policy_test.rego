package lib.terraform.CB_TFAWS_131

test_mskcluster_logging_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_rds_cluster",
			"test",
		],
		"Attributes": {"backup_retention_period": "30"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_mskcluster_logging_enabled_false {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_rds_cluster",
			"test",
		],
		"Attributes": {"backup_retention_period": "0"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
