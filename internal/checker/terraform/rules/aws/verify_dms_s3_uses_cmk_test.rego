package lib.terraform.CB_TFAWS_263

import rego.v1 

test_dms_s3_uses_cmk if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dms_s3_endpoint",
			"example",
		],
		"Attributes": {"kms_key_arn": "arn:aws:kms:us-west-2:123456789012:key/abcd1234-efgh-5678-ijkl-901234567890"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_dms_s3_not_uses_cmk if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dms_s3_endpoint",
			"example",
		],
		"Attributes": {},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
