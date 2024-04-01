package lib.terraform.CB_TFAWS_289

import rego.v1 

test_aws_dms_endpoint_utilizing_cmk_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dms_endpoint",
			"example",
		],
		"Attributes": {"engine_name": "s3"},
		"Blocks": [{
			"Type": "s3_settings",
			"Labels": [],
			"Attributes": {"server_side_encryption_kms_key_id": "your_kms_key_id"},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_dms_endpoint_utilizing_cmk_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dms_endpoint",
			"example",
		],
		"Attributes": {"engine_name": "s3"},
		"Blocks": [{
			"Type": "s3_settings",
			"Labels": [],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
