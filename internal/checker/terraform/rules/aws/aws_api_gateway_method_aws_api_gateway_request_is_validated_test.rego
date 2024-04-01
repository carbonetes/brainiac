package lib.terraform.CB_TFAWS_356

import rego.v1 

test_aws_api_gateway_method_aws_api_gateway_request_is_validated_passed if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_api_gateway_request_validator",
				"example",
			],
			"Attributes": {
				"name": "example-validator",
				"rest_api_id": "aws_api_gateway_rest_api.example.id",
				"validate_request_body": true,
				"validate_request_parameters": true,
			},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_api_gateway_method",
				"example",
			],
			"Attributes": {"request_validator_id": "aws_api_gateway_request_validator.example.id"},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 8,
			},
		},
	]
	count(result) == 1
}

test_aws_api_gateway_method_aws_api_gateway_request_is_validated_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_api_gateway_method",
			"example",
		],
		"Attributes": {},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 8,
		},
	}]
	count(result) == 1
}
