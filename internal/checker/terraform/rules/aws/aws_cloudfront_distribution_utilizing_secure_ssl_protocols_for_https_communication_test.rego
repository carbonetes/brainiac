package lib.terraform.CB_TFAWS_361

import rego.v1 

test_aws_cloudfront_distribution_utilizing_secure_ssl_protocols_for_https_communication_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudfront_distribution",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "origin",
			"Labels": [],
			"Attributes": {"domain_name": "example.com"},
			"Blocks": [{
				"Type": "custom_origin_config",
				"Labels": [],
				"Attributes": {
					"http_port": "80",
					"https_port": "443",
					"origin_protocol_policy": "http-only",
					"origin_ssl_protocols": [
						"TLSv1.2",
						"TLSv1.3",
					],
				},
				"Blocks": [],
				"line_range": {
					"endLine": 12,
					"startLine": 7,
				},
			}],
			"line_range": {
				"endLine": 13,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 16,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_cloudfront_distribution_utilizing_secure_ssl_protocols_for_https_communication_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudfront_distribution",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "origin",
			"Labels": [],
			"Attributes": {"domain_name": "example.com"},
			"Blocks": [{
				"Type": "custom_origin_config",
				"Labels": [],
				"Attributes": {
					"http_port": "80",
					"https_port": "443",
					"origin_protocol_policy": "http-only",
					"origin_ssl_protocols": [
						"TLSv1.2",
						"TLSv1.3",
						"SSLv3",
					],
				},
				"Blocks": [],
				"line_range": {
					"endLine": 12,
					"startLine": 7,
				},
			}],
			"line_range": {
				"endLine": 13,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 16,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
