package lib.terraform.CB_TFAWS_006
import rego.v1

test_key_rotation_not_secured_pass if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_kms_key",
			"example",
		],
		"Attributes": {
			"deletion_window_in_days": "30",
			"description": "Example key for testing",
			"enable_key_rotation": true,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 50,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_key_rotation_not_secured_fail if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_kms_key",
			"example",
		],
		"Attributes": {
			"deletion_window_in_days": "30",
			"description": "Example key for testing",
			"enable_key_rotation": false,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 50,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
