package lib.terraform.CB_TFAWS_326

import rego.v1 

test_aws_api_gateway_method_settings_api_gateway_have_logging_level_defined_as_appropriate_passed if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_api_gateway_rest_api",
				"ok_example",
			],
			"Attributes": {"name": "ok_example"},
			"Blocks": [],
			"line_range": {
				"endLine": 23,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_api_gateway_deployment",
				"ok_example",
			],
			"Attributes": {"rest_api_id": "aws_api_gateway_rest_api.ok_example.id"},
			"Blocks": [{
				"Type": "lifecycle",
				"Labels": [],
				"Attributes": {"create_before_destroy": true},
				"Blocks": [],
				"line_range": {
					"endLine": 34,
					"startLine": 32,
				},
			}],
			"line_range": {
				"endLine": 35,
				"startLine": 25,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_api_gateway_stage",
				"ok_example",
			],
			"Attributes": {
				"deployment_id": "aws_api_gateway_deployment.ok_example.id",
				"rest_api_id": "aws_api_gateway_rest_api.ok_example.id",
				"stage_name": "ok_example",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 41,
				"startLine": 37,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_api_gateway_method_settings",
				"all",
			],
			"Attributes": {
				"method_path": "*/*",
				"rest_api_id": "aws_api_gateway_rest_api.ok_example.id",
				"stage_name": "aws_api_gateway_stage.ok_example.stage_name",
			},
			"Blocks": [{
				"Type": "settings",
				"Labels": [],
				"Attributes": {
					"logging_level": "ERROR",
					"metrics_enabled": true,
				},
				"Blocks": [],
				"line_range": {
					"endLine": 51,
					"startLine": 48,
				},
			}],
			"line_range": {
				"endLine": 52,
				"startLine": 43,
			},
		},
	]
	count(result) == 1
}

test_aws_api_gateway_method_settings_api_gateway_have_logging_level_defined_as_appropriate_failed if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_api_gateway_rest_api",
				"ok_example",
			],
			"Attributes": {"name": "ok_example"},
			"Blocks": [],
			"line_range": {
				"endLine": 23,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_api_gateway_deployment",
				"ok_example",
			],
			"Attributes": {"rest_api_id": "aws_api_gateway_rest_api.ok_example.id"},
			"Blocks": [{
				"Type": "lifecycle",
				"Labels": [],
				"Attributes": {"create_before_destroy": true},
				"Blocks": [],
				"line_range": {
					"endLine": 34,
					"startLine": 32,
				},
			}],
			"line_range": {
				"endLine": 35,
				"startLine": 25,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_api_gateway_stage",
				"ok_example",
			],
			"Attributes": {
				"deployment_id": "aws_api_gateway_deployment.ok_example.id",
				"rest_api_id": "aws_api_gateway_rest_api.ok_example.id",
				"stage_name": "ok_example",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 41,
				"startLine": 37,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_api_gateway_method_settings",
				"all",
			],
			"Attributes": {
				"method_path": "*/*",
				"rest_api_id": "aws_api_gateway_rest_api.ok_example.id",
				"stage_name": "",
			},
			"Blocks": [{
				"Type": "settings",
				"Labels": [],
				"Attributes": {
					"logging_level": "",
					"metrics_enabled": false,
				},
				"Blocks": [],
				"line_range": {
					"endLine": 51,
					"startLine": 48,
				},
			}],
			"line_range": {
				"endLine": 52,
				"startLine": 43,
			},
		},
	]
	count(result) == 1
}
