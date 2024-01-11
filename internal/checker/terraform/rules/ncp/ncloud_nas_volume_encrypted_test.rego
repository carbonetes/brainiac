package lib.terraform.CB_TFNCP_014

test_ncloud_nas_volume_encrypted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_nas_volume",
			"example",
		],
		"Attributes": {
			"is_encrypted_volume": true,
			"name": "example-nas",
			"size": "100",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ncloud_nas_volume_encrypted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_nas_volume",
			"example",
		],
		"Attributes": {
			"is_encrypted_volume": false,
			"name": "example-nas",
			"size": "100",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
