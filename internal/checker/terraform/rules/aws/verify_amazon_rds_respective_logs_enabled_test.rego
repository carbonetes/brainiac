package lib.terraform.CB_TFAWS_126
import rego.v1

test_amazon_rds_respective_logs_enabled if{
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_db_instance",
			"mysql",
		],
		"Attributes": {
			"allocated_storage": "5",
			"enabled_cloudwatch_logs_exports": [
				"general",
				"error",
				"slowquery",
			],
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_amazon_rds_respective_logs_not_set if{
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_db_instance",
			"mysql",
		],
		"Attributes": {
			"allocated_storage": "5",
			"enabled_cloudwatch_logs_exports": [],
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
