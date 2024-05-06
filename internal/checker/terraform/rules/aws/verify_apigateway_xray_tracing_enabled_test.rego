package lib.terraform.CB_TFAWS_081
import rego.v1

test_apigateway_xray_tracing_enabled if {
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

test_apigateway_xray_tracing_not_enabled if {
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
