package lib.terraform.CB_TFAWS_196

test_ebs_volume_encrypted_kms_cmk {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dms_replication_instance",
			"example",
		],
		"Attributes": {"kms_key_id": "kms"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ebs_volume_not_encrypted_kms_cmk {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dms_replication_instance",
			"example",
		],
		"Attributes": {"kms_key_id": ""},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
