package lib.terraform.CB_TFAWS_028
import rego.v1

test_aws_efs_file_system_encrypted_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_efs_file_system",
			"example",
		],
		"Attributes": {
			"creation_token": "example-efs",
			"encrypted": true,
			"performance_mode": "generalPurpose",
		},
		"Blocks": [{
			"Type": "lifecycle_policy",
			"Labels": [],
			"Attributes": {"transition_to_ia": "AFTER_30_DAYS"},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_efs_file_system_encrypted_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_efs_file_system",
			"example",
		],
		"Attributes": {
			"creation_token": "example-efs",
			"encrypted": false,
			"performance_mode": "generalPurpose",
		},
		"Blocks": [{
			"Type": "lifecycle_policy",
			"Labels": [],
			"Attributes": {"transition_to_ia": "AFTER_30_DAYS"},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
