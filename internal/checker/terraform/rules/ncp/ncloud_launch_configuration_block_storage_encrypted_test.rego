package lib.terraform.CB_TFNCP_007

test_ncloud_launch_configuration_block_storage_encrypted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_launch_configuration",
			"example",
		],
		"Attributes": {"is_encrypted_volume": true},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ncloud_launch_configuration_block_storage_encrypted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_launch_configuration",
			"example",
		],
		"Attributes": {"is_encrypted_volume": false},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
