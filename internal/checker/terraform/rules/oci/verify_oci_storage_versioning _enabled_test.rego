package lib.terraform.CB_TFOCI_009

test_oci_storage_versioning_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_objectstorage_bucket",
			"pass",
		],
		"Attributes": {"versioning": "Enabled"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_oci_storage_versioning_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_objectstorage_bucket",
			"pass",
		],
		"Attributes": {"versioning": "Disabled"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
