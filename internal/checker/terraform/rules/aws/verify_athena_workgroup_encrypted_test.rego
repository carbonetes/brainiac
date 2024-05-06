package lib.terraform.CB_TFAWS_137
import rego.v1

test_athena_workgroup_encrypted if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_athena_workgroup",
			"test",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "configuration",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "result_configuration",
				"Labels": [],
				"Attributes": {"output_location": "s3://mys3bucket"},
				"Blocks": [{
					"Type": "encryption_configuration",
					"Labels": [],
					"Attributes": {
						"encryption_option": "SSE_KMS",
						"kms_key_arn": "mykmsarn",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 10,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 11,
					"startLine": 5,
				},
			}],
			"line_range": {
				"endLine": 12,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_athena_workgroup_not_encrypted if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_athena_workgroup",
			"test",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "configuration",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "result_configuration",
				"Labels": [],
				"Attributes": {"output_location": "s3://mys3bucket"},
				"Blocks": [{
					"Type": "encryption_configuration",
					"Labels": [],
					"Attributes": {"kms_key_arn": "mykmsarn"},
					"Blocks": [],
					"line_range": {
						"endLine": 10,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 11,
					"startLine": 5,
				},
			}],
			"line_range": {
				"endLine": 12,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
