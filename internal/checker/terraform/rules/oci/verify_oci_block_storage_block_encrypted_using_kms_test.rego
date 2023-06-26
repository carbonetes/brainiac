package lib.terraform.CB_TFOCI_004

test_no_hardcoded_private_key {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_core_volume",
			"pass",
		],
		"Attributes": {"kms_key_id": "oci_kms_key.test_key.id"},
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
		"Type": "resource",
		"Labels": [
			"oci_core_volume",
			"pass",
		],
		"Attributes": {},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
