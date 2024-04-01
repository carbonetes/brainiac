package lib.terraform.CB_TFAWS_038
import rego.v1

test_s3_bucket_versioning_enabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_s3_bucket_versioning",
			"versioning_example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "versioning_configuration",
			"Labels": [],
			"Attributes": {"status": "Enabled"},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_s3_bucket_versioning_disabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_s3_bucket_versioning",
			"versioning_example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "versioning_configuration",
			"Labels": [],
			"Attributes": {"status": "Disabled"},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
