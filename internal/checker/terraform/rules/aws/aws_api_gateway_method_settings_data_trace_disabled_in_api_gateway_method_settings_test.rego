package lib.terraform.CB_TFAWS_251

import rego.v1

test_aws_api_gateway_method_settings_data_trace_disabled_in_api_gateway_method_settings_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_api_gateway_method_settings",
			"example",
		],
		"Attributes": {
			"rest_api_id": "aws_api_gateway_rest_api.example.id",
			"stage_name": "prod",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {
				"data_trace_enabled": false,
				"method_path": "/*/*",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_api_gateway_method_settings_data_trace_disabled_in_api_gateway_method_settings_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_api_gateway_method_settings",
			"example",
		],
		"Attributes": {
			"rest_api_id": "aws_api_gateway_rest_api.example.id",
			"stage_name": "prod",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {
				"data_trace_enabled": true,
				"method_path": "/*/*",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
