package lib.terraform.CB_TFAWS_123

test_aws_intances_monitoring_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_instance",
			"test",
		],
		"Attributes": {"monitoring": true},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_intances_monitoring_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_instance",
			"test",
		],
		"Attributes": {"monitoring": false},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
