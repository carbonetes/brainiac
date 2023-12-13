package lib.terraform.CB_TFALI_001

test_alicloud_oss_bucket_private {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_oss_bucket",
			"good-bucket",
		],
		"Attributes": {
			"acl": "private",
			"bucket": "bucket-1732-acl",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_alicloud_oss_bucket_public {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_oss_bucket",
			"good-bucket",
		],
		"Attributes": {
			"acl": "public-read",
			"bucket": "bucket-1732-acl",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
