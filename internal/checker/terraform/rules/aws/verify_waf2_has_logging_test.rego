package lib.terraform.CB_TFAWS_334

import rego.v1

test_waf2_has_logging_enabled if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_wafv2_web_acl",
				"example",
			],
			"Attributes": {
				"description": "Example of a rate based statement.",
				"name": "rate-based-example",
				"scope": "REGIONAL",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 11,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_wafv2_web_acl_logging_configuration",
				"example",
			],
			"Attributes": {
				"log_destination_configs": "aws_kinesis_firehose_delivery_stream.example.arn",
				"resource_arn": "aws_wafv2_web_acl.example.arn",
			},
			"Blocks": [{
				"Type": "redacted_fields",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "single_header",
					"Labels": [],
					"Attributes": {"name": "user-agent"},
					"Blocks": [],
					"line_range": {
						"endLine": 19,
						"startLine": 17,
					},
				}],
				"line_range": {
					"endLine": 20,
					"startLine": 16,
				},
			}],
			"line_range": {
				"endLine": 21,
				"startLine": 13,
			},
		},
	]
	count(result) == 1
}

test_waf2_no_logging_enabled if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_wafv2_web_acl",
				"test",
			],
			"Attributes": {
				"description": "Example of a rate based statement.",
				"name": "rate-based-example",
				"scope": "REGIONAL",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 11,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_wafv2_web_acl_logging_configuration",
				"example",
			],
			"Attributes": {
				"log_destination_configs": "aws_kinesis_firehose_delivery_stream.example.arn",
				"resource_arn": "aws_wafv2_web_acl.example.arn",
			},
			"Blocks": [{
				"Type": "redacted_fields",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "single_header",
					"Labels": [],
					"Attributes": {"name": "user-agent"},
					"Blocks": [],
					"line_range": {
						"endLine": 19,
						"startLine": 17,
					},
				}],
				"line_range": {
					"endLine": 20,
					"startLine": 16,
				},
			}],
			"line_range": {
				"endLine": 21,
				"startLine": 13,
			},
		},
	]
	count(result) == 1
}
