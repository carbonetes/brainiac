package lib.terraform.CB_TFAWS_123
import rego.v1

test_aws_intances_monitoring_enabled if {
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

test_aws_intances_monitoring_not_enabled if {
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
