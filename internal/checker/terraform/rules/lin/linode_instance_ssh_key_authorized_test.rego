package lib.terraform.CB_TFLIN_001

test_linode_instance_ssh_key_authorized_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"linode_instance",
			"example",
		],
		"Attributes": {"authorized_keys": ["valid_key"]},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_linode_instance_ssh_key_authorized_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"linode_instance",
			"example",
		],
		"Attributes": {"authorized_keys": []},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
