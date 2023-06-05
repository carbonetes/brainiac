package lib.terraform.CB_TFAWS_081

test_apigateway_xray_tracing_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_api_gateway_stage",
			"test",
		],
		"Attributes": {
			"stage_name": "prod",
			"xray_tracing_enabled": true,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_apigateway_xray_tracing_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_api_gateway_stage",
			"test",
		],
		"Attributes": {
			"stage_name": "prod",
			"xray_tracing_enabled": false,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
