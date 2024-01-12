package lib.terraform.CB_TFNCP_018

test_ncloud_nks_cluster_public_endpoint_disabled_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_nks_cluster",
			"example",
		],
		"Attributes": {"public_network": false},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ncloud_nks_cluster_public_endpoint_disabled_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_nks_cluster",
			"example",
		],
		"Attributes": {"public_network": true},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
