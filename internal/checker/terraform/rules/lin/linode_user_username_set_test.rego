package lib.terraform.CB_TFLIN_003

test_linode_user_username_set_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"linode_user",
			"example_user",
		],
		"Attributes": {
			"email": "user@example.com",
			"password": "example_password",
			"username": "example_username",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_linode_user_username_set_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"linode_user",
			"example_user",
		],
		"Attributes": {
			"email": "user@example.com",
			"password": "example_password",
			"username": "",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
