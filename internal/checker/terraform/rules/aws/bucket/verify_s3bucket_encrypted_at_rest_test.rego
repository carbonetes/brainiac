package lib.terraform.CB_TFAWS_024
import rego.v1

test_s3_bucket_encrypted if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_s3_bucket",
			"example",
		],
		"Attributes": {"bucket": "example-bucket"},
		"Blocks": [{
			"Type": "server_side_encryption_configuration",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "rule",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "apply_server_side_encryption_by_default",
					"Labels": [],
					"Attributes": {"sse_algorithm": "AES256"},
					"Blocks": [],
					"line_range": {
						"endLine": 8,
						"startLine": 6,
					},
				}],
				"line_range": {
					"endLine": 9,
					"startLine": 5,
				},
			}],
			"line_range": {
				"endLine": 10,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_s3_bucket_not_encrypted if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_s3_bucket",
			"example",
		],
		"Attributes": {"bucket": "example-bucket"},
		"Blocks": [{
			"Type": "server_side_encryption_configuration",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "rule",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "apply_server_side_encryption_by_default",
					"Labels": [],
					"Attributes": {},
					"Blocks": [],
					"line_range": {
						"endLine": 8,
						"startLine": 6,
					},
				}],
				"line_range": {
					"endLine": 9,
					"startLine": 5,
				},
			}],
			"line_range": {
				"endLine": 10,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
