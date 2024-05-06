package lib.terraform.CB_TFAWS_207
import rego.v1

test_lifecycle_create_before_destroy_enabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_api_gateway_deployment",
			"example",
		],
		"Attributes": {
			"rest_api_id": "aws_api_gateway_rest_api.example.id",
			"stage_name": "example",
		},
		"Blocks": [{
			"Type": "lifecycle",
			"Labels": [],
			"Attributes": {"create_before_destroy": true},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_lifecycle_create_before_destroy_not_enabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_api_gateway_deployment",
			"example",
		],
		"Attributes": {
			"rest_api_id": "aws_api_gateway_rest_api.example.id",
			"stage_name": "example",
		},
		"Blocks": [{
			"Type": "lifecycle",
			"Labels": [],
			"Attributes": {"create_before_destroy": false},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
}
