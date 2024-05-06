package lib.terraform.CB_TFAWS_255

import rego.v1

test_kendra_index_server_side_encryption_cmk if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_kendra_index",
			"pass",
		],
		"Attributes": {
			"name": "example",
			"role_arn": "aws_iam_role.this.arn",
		},
		"Blocks": [{
			"Type": "server_side_encryption_configuration",
			"Labels": [],
			"Attributes": {"kms_key_id": "data.aws_kms_key.this.arn"},
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

test_kendra_index_server_side_encryption_not_uses_cmk if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_kendra_index",
			"pass",
		],
		"Attributes": {
			"name": "example",
			"role_arn": "aws_iam_role.this.arn",
		},
		"Blocks": [{
			"Type": "server_side_encryption_configuration",
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
