package lib.terraform.CB_TFAWS_291

import rego.v1 

test_apigateway_method_setting_caching_encrypted if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_api_gateway_method_settings",
			"s",
		],
		"Attributes": {
			"method_path": "aws_api_gateway_resource.test.path_part",
			"rest_api_id": "aws_api_gateway_rest_api.test.id",
			"stage_name": "aws_api_gateway_stage.test.stage_name",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {
				"cache_data_encrypted": true,
				"logging_level": "INFO",
				"metrics_enabled": true,
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_apigateway_method_setting_caching_not_encrypted if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_api_gateway_method_settings",
			"s",
		],
		"Attributes": {
			"method_path": "aws_api_gateway_resource.test.path_part",
			"rest_api_id": "aws_api_gateway_rest_api.test.id",
			"stage_name": "aws_api_gateway_stage.test.stage_name",
		},
		"Blocks": [{
			"Type": "settings",
			"Labels": [],
			"Attributes": {
				"cache_data_encrypted": false,
				"logging_level": "INFO",
				"metrics_enabled": true,
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
