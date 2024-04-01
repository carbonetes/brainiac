package lib.terraform.CB_TFAWS_257

import rego.v1

test_app_flow_flow_uses_cmk if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_appflow_flow",
			"pass",
		],
		"Attributes": {"kms_arn": "aws_kms_key.example.arn"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_app_flow_flow_not_uses_cmk if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_appflow_flow",
			"pass",
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
