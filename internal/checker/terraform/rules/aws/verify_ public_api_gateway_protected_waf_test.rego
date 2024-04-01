package lib.terraform.CB_TFAWS_331

import rego.v1 

test_public_gateway_protected_by_waf if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_api_gateway_rest_api",
				"edge",
			],
			"Attributes": {
				"name": "var.name",
				"policy": "",
			},
			"Blocks": [{
				"Type": "endpoint_configuration",
				"Labels": [],
				"Attributes": {"types": ["PRIVATE"]},
				"Blocks": [],
				"line_range": {
					"endLine": 8,
					"startLine": 6,
				},
			}],
			"line_range": {
				"endLine": 9,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_api_gateway_stage",
				"wafv2_edge",
			],
			"Attributes": {
				"rest_api_id": "aws_api_gateway_rest_api.edge.id",
				"stage_name": "example",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 15,
				"startLine": 11,
			},
		},
	]
	count(result) == 1
}

test_public_gateway_not_protected_by_waf if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_api_gateway_stage",
				"wafv2_edge",
			],
			"Attributes": {
				"rest_api_id": "aws_api_gateway_rest_api.edge.id",
				"stage_name": "example",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 15,
				"startLine": 11,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_api_gateway_rest_api",
				"edge",
			],
			"Attributes": {
				"name": "var.name",
				"policy": "",
			},
			"Blocks": [{
				"Type": "endpoint_configuration",
				"Labels": [],
				"Attributes": {"types": ["EDGE"]},
				"Blocks": [],
				"line_range": {
					"endLine": 8,
					"startLine": 6,
				},
			}],
			"line_range": {
				"endLine": 9,
				"startLine": 1,
			},
		},
	]
	count(result) == 1
}
