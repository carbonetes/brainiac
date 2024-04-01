package lib.terraform.CB_TFAWS_134
import rego.v1

test_cloudwatch_log_group_encrypted if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudwatch_log_group",
			"example_log_group",
		],
		"Attributes": {
			"kms_key_id": "aws_kms_key.example_kms_key.key_id",
			"name": "example-log-group",
			"retention_in_days": "30",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloudwatch_log_group_not_encrypted if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudwatch_log_group",
			"example_log_group",
		],
		"Attributes": {
			"name": "example-log-group",
			"retention_in_days": "30",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
