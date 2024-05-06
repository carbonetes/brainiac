package lib.terraform.CB_TFAWS_111
import rego.v1

test_dynamodb_tables_encrypted if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dynamodb_table",
			"basic-dynamodb-table",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "server_side_encryption",
			"Labels": [],
			"Attributes": {
				"enabled": true,
				"kms_key_arn": "aws_kms_key.dynamo.arn",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_dynamodb_tables_not_encrypted if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dynamodb_table",
			"basic-dynamodb-table",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "server_side_encryption",
			"Labels": [],
			"Attributes": {
				"enabled": false,
				"kms_key_arn": "aws_kms_key.dynamo.arn",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
