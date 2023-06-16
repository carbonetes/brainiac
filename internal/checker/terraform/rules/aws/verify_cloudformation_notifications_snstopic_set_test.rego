package lib.terraform.CB_TFAWS_120

test_cloudformation_sending_notifications_to_sns {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudformation_stack",
			"default",
		],
		"Attributes": {
			"name": "networking-stack",
			"notification_arns": [
				"arn1",
				"arn2",
			],
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_cloudformation_sending_notifications_to_sns_not_set {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudformation_stack",
			"default",
		],
		"Attributes": {"name": "networking-stack"},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
