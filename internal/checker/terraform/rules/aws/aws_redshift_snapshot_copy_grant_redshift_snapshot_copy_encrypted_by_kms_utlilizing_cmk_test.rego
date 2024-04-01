package lib.terraform.CB_TFAWS_265

import rego.v1 

test_aws_redshift_snapshot_copy_grant_redshift_snapshot_copy_encrypted_by_kms_utlilizing_cmk_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_redshift_snapshot_copy_grant",
			"example",
		],
		"Attributes": {"kms_key_id": "any"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_redshift_snapshot_copy_grant_redshift_snapshot_copy_encrypted_by_kms_utlilizing_cmk_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_redshift_snapshot_copy_grant",
			"example",
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
