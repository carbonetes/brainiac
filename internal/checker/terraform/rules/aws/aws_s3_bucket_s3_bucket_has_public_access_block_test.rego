package lib.terraform.CB_TFAWS_328

import rego.v1 

test_aws_s3_bucket_s3_bucket_has_public_access_block_passed if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_s3_bucket",
				"bucket_good_1",
			],
			"Attributes": {"bucket": "bucket_good"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_s3_bucket_public_access_block",
				"access_good_1",
			],
			"Attributes": {
				"block_public_acls": true,
				"block_public_policy": true,
				"bucket": "aws_s3_bucket.bucket_good_1.id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 11,
				"startLine": 6,
			},
		},
	]
	count(result) == 1
}

test_aws_s3_object_copy_encrypted_by_kms_utilizing_cmk_failed if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_s3_bucket",
				"bucket_good_1",
			],
			"Attributes": {"bucket": "bucket_good"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_s3_bucket_public_access_block",
				"access_good_1",
			],
			"Attributes": {
				"block_public_acls": false,
				"block_public_policy": false,
				"bucket": "aws_s3_bucket.bucket_good_1.id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 11,
				"startLine": 6,
			},
		},
	]
	count(result) == 1
}
