package lib.terraform.CB_TFAWS_293

import rego.v1 

test_cloudfront_distribution_failover_configured if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudfront_distribution",
			"s3_distribution",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "origin_group",
			"Labels": [],
			"Attributes": {"origin_id": "groupS3"},
			"Blocks": [
				{
					"Type": "failover_criteria",
					"Labels": [],
					"Attributes": {"status_codes": [
						"403",
						"404",
						"500",
						"502",
					]},
					"Blocks": [],
					"line_range": {
						"endLine": 7,
						"startLine": 5,
					},
				},
				{
					"Type": "member",
					"Labels": [],
					"Attributes": {"origin_id": "primaryS3"},
					"Blocks": [],
					"line_range": {
						"endLine": 11,
						"startLine": 9,
					},
				},
				{
					"Type": "member",
					"Labels": [],
					"Attributes": {"origin_id": "failoverS3"},
					"Blocks": [],
					"line_range": {
						"endLine": 15,
						"startLine": 13,
					},
				},
			],
			"line_range": {
				"endLine": 16,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 17,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloudfront_distribution_failover_not_configured if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudfront_distribution",
			"s3_distribution",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "origin_group",
			"Labels": [],
			"Attributes": {"origin_id": "groupS3"},
			"Blocks": [
				{
					"Type": "failover_criteria",
					"Labels": [],
					"Attributes": {"status_codes": [
						"403",
						"404",
						"500",
						"502",
					]},
					"Blocks": [],
					"line_range": {
						"endLine": 7,
						"startLine": 5,
					},
				},
				{
					"Type": "member",
					"Labels": [],
					"Attributes": {"origin_id": "primaryS3"},
					"Blocks": [],
					"line_range": {
						"endLine": 11,
						"startLine": 9,
					},
				},
			],
			"line_range": {
				"endLine": 16,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 17,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
