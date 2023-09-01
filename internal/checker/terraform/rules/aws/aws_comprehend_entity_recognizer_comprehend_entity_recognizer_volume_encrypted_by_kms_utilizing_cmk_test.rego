package lib.terraform.CB_TFAWS_243

test_aws_comprehend_entity_recognizer_comprehend_entity_recognizer_volume_encrypted_by_kms_utilizing_cmk_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_comprehend_entity_recognizer",
			"example",
		],
		"Attributes": {"volume_kms_key_id": "kms_key_id"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_comprehend_entity_recognizer_comprehend_entity_recognizer_volume_encrypted_by_kms_utilizing_cmk_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_comprehend_entity_recognizer",
			"example",
		],
		"Attributes": {"volume_kms_key_id": ""},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
