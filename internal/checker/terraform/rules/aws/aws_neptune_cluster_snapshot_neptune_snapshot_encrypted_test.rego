package lib.terraform.CB_TFAWS_261

test_aws_neptune_cluster_snapshot_neptune_snapshot_encrypted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_neptune_cluster_snapshot",
			"example",
		],
		"Attributes": {"storage_encrypted": true},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_neptune_cluster_snapshot_neptune_snapshot_encrypted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_neptune_cluster_snapshot",
			"example",
		],
		"Attributes": {"storage_encrypted": false},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
