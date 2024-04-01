package lib.terraform.CB_TFAWS_208
import rego.v1

test_cloudsearch_using_latest_tls if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudsearch_domain",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "endpoint_options",
			"Labels": [],
			"Attributes": {
				"enforce_https": false,
				"tls_security_policy": "Policy-Min-TLS-1-2-2019-07",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloudsearch_not_using_latest_tls if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_cloudsearch_domain",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "endpoint_options",
			"Labels": [],
			"Attributes": {
				"enforce_https": false,
				"tls_security_policy": "Policy-Min-TLS-1-2-2017-07",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
