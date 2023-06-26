package lib.terraform.CB_TFOCI_001

test_no_hardcoded_private_key {
	result := passed with input as [{
		"Type": "provider",
		"Labels": ["oci"],
		"Attributes": {},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_hardcoded_private_key {
	result := failed with input as [{
		"Type": "provider",
		"Labels": ["oci"],
		"Attributes": {"private_key_password": "secretPassword"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
