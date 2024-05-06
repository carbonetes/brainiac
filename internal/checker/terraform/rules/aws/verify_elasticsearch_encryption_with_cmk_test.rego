package lib.terraform.CB_TFAWS_278

import rego.v1 

test_verify_elasticsearch_encryption_with_cmk_passed if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_elasticsearch_domain",
				"pass"
			],
			"Attributes": {},
			"Blocks": [
				{
					"Type": "encrypt_at_rest",
					"Labels": [],
					"Attributes": {
						"kms_key_id": "aws_kms_key.example.arn"
					},
					"Blocks": [],
					"line_range": {
						"endLine": 4,
						"startLine": 2
					}
				}
			],
			"line_range": {
				"endLine": 5,
				"startLine": 1
			}
		}
	]
	count(result) == 1
}

test_verify_elasticsearch_encryption_with_cmk_failed if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_elasticsearch_domain",
				"pass"
			],
			"Attributes": {},
			"Blocks": [
				{
					"Type": "encrypt_at_rest",
					"Labels": [],
					"Attributes": {
						"kms_key_id": ""
					},
					"Blocks": [],
					"line_range": {
						"endLine": 4,
						"startLine": 2
					}
				}
			],
			"line_range": {
				"endLine": 5,
				"startLine": 1
			}
		}
	]
	count(result) == 1
}
