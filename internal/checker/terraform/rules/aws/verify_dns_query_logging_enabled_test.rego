package lib.terraform.CB_TFAWS_349

import rego.v1

test_dns_query_logging_enabled if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_route53_zone",
				"example",
			],
			"Attributes": {"name": "example.com"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_route53_query_log",
				"example",
			],
			"Attributes": {
				"count": "var.enable_dns_query_logging",
				"zone_id": "aws_route53_zone.example.zone_id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}

test_dns_query_not_logging_enabled if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_route53_zone",
				"example",
			],
			"Attributes": {"name": "example.com"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_route53_query_log",
				"example",
			],
			"Attributes": {
				"count": "var.enable_dns_query_logging",
				"zone_id": "aws_route53_zone.fail.zone_id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}
