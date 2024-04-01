package lib.terraform.CB_TFAWS_089
import rego.v1

test_instance_metadata_service_v1_not_enabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_instance",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "metadata_options",
			"Labels": [],
			"Attributes": {
				"http_endpoint": "disabled",
				"http_tokens": "required",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_instance_metadata_service_v1_enabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_instance",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "metadata_options",
			"Labels": [],
			"Attributes": {
			},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
