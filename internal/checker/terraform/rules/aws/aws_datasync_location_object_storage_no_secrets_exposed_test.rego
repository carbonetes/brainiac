package lib.terraform.CB_TFAWS_286

import rego.v1

test_aws_datasync_location_object_storage_no_secrets_exposed_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_datasync_location_object_storage",
			"example",
		],
		"Attributes": {},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_datasync_location_object_storage_no_secrets_exposed_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_datasync_location_object_storage",
			"example",
		],
		"Attributes": {"secret_key": "your_secret_key_here"},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
