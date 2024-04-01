package lib.terraform.CB_TFAWS_246

import rego.v1

test_aws_dynamodb_table_replica_encrypted_by_kms_utlizing_cmk_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dynamodb_table_replica",
			"example",
		],
		"Attributes": {"kms_key_arn": "kms_key_arn"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_dynamodb_table_replica_encrypted_by_kms_utlizing_cmk_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dynamodb_table_replica",
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
