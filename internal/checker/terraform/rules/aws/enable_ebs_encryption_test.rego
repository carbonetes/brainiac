package lib.terraform.CB_TFAWS_003
import rego.v1

test_enable_ebs_encryption_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_ebs_volume",
			"example",
		],
		"Attributes": {
			"deletion_window_in_days": "30",
			"description": "Example key for testing",
			"encrypted": true,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 50,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_enable_ebs_encryption_faied if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_ebs_volume",
			"example",
		],
		"Attributes": {
			"deletion_window_in_days": "30",
			"description": "Example key for testing",
			"encrypted": false,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 50,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
