package lib.terraform.CB_TFOCI_010

test_oci_storage_kms_encrypted {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_objectstorage_bucket",
			"pass",
		],
		"Attributes": {"kms_key_id": "var.oci_kms_key.id"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_oci_storage_not_kms_encrypted {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_objectstorage_bucket",
			"pass",
		],
		"Attributes": {"kms_key_id": ""},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
