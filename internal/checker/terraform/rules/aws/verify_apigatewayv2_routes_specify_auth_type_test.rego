package lib.terraform.CB_TFAWS_292

import rego.v1 

test_apigatewayv2_routes_specify_auth_type if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_apigatewayv2_route",
			"example",
		],
		"Attributes": {"authorization_type": "AWS_IAM"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_apigatewayv2_routes_not_specify_auth_type if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_apigatewayv2_route",
			"example",
		],
		"Attributes": {"authorization_type": "NONE"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
