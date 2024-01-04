package lib.terraform.CB_TFNCP_006

test_ncloud_server_server_instance_encrypted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_server",
			"example",
		],
		"Attributes": {"is_encrypted_base_block_storage_volume": true},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ncloud_server_server_instance_encrypted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_server",
			"example",
		],
		"Attributes": {"is_encrypted_base_block_storage_volume": false},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
