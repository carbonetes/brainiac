package lib.terraform.CB_TFOCI_011

test_oci_storage_not_public {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_objectstorage_bucket",
			"pass2",
		],
		"Attributes": {"access_type": "NoPublicAccess"},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_oci_storage_public {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_objectstorage_bucket",
			"pass2",
		],
		"Attributes": {"access_type": "ObjectRead"},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
