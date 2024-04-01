package lib.terraform.CB_TFAWS_335

import rego.v1 

test_appsync_waf_protected if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_appsync_graphql_api",
				"pass",
			],
			"Attributes": {
				"authentication_type": "API_KEY",
				"name": "example",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_wafv2_web_acl_association",
				"pass",
			],
			"Attributes": {
				"resource_arn": "aws_appsync_graphql_api.pass.arn",
				"web_acl_arn": "aws_wafv2_web_acl.example.arn",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 6,
			},
		},
	]
	count(result) == 1
}

test_appsync_not_waf_protected if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_appsync_graphql_api",
				"pass",
			],
			"Attributes": {
				"authentication_type": "API_KEY",
				"name": "example",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_wafv2_web_acl_association",
				"pass",
			],
			"Attributes": {"web_acl_arn": "aws_wafv2_web_acl.example.arn"},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 6,
			},
		},
	]
	count(result) == 1
}
