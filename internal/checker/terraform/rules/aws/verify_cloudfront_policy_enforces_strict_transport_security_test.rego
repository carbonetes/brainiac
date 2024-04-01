package lib.terraform.CB_TFAWS_247

import rego.v1

test_cloudfront_policy_enforces_strict_transport_security if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudfront_response_headers_policy",
			"pass",
		],
		"Attributes": {"name": "test"},
		"Blocks": [{
			"Type": "security_headers_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "strict_transport_security",
				"Labels": [],
				"Attributes": {
					"access_control_max_age_sec": "3.1536e+07",
					"include_subdomains": true,
					"override": true,
					"preload": true,
				},
				"Blocks": [],
				"line_range": {
					"endLine": 10,
					"startLine": 5,
				},
			}],
			"line_range": {
				"endLine": 11,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloudfront_policy_not_enforces_strict_transport_security if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudfront_response_headers_policy",
			"pass",
		],
		"Attributes": {"name": "test"},
		"Blocks": [{
			"Type": "security_headers_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "strict_transport_security",
				"Labels": [],
				"Attributes": {
					"access_control_max_age_sec": "3.1536e+07",
					"include_subdomains": false,
					"override": false,
					"preload": false,
				},
				"Blocks": [],
				"line_range": {
					"endLine": 10,
					"startLine": 5,
				},
			}],
			"line_range": {
				"endLine": 11,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
