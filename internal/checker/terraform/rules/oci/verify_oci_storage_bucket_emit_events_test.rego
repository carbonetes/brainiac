package lib.terraform.CB_TFOCI_008

test_oci_storage_events_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_objectstorage_bucket",
			"pass",
		],
		"Attributes": {"object_events_enabled": true},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_oci_storage_events_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_objectstorage_bucket",
			"pass",
		],
		"Attributes": {"object_events_enabled": false},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
