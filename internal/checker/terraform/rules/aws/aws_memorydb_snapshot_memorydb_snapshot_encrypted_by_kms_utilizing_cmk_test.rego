package lib.terraform.CB_TFAWS_259

import rego.v1 

test_aws_memorydb_snapshot_memorydb_snapshot_encrypted_by_kms_utilizing_cmk_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_memorydb_snapshot",
			"example",
		],
		"Attributes": {"kms_key_arn": "any"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_memorydb_snapshot_memorydb_snapshot_encrypted_by_kms_utilizing_cmk_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_memorydb_snapshot",
			"example",
		],
		"Attributes": {"kms_key_arn": ""},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
