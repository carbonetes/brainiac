package lib.terraform.CB_TFAWS_138

test_timestream_database_encrypted {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_timestreamwrite_database",
			"test",
		],
		"Attributes": {"kms_key_id": "var.kms_key_id"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_timestream_database_not_encrypted {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_timestreamwrite_database",
			"test",
		],
		"Attributes": {},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
